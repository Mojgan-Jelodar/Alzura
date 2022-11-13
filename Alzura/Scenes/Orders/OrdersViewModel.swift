//
//  OrdersViewModel.swift
//  Alzura
//
//  Created by Mozhgan on 11/12/22.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation
import Combine

enum OrdersViewEvent {
    case viewDidLoad
    case sort
    case logout
    case refresh
    case more
    case didSelect(indexPath : IndexPath)
}
enum ReloadStrategy  {
    case whole
    case visibleItems(indexPathsToReload : [IndexPath])
}
enum OrdersViewState  {
    case isLoading
    case failed(error : Error)
    case loaded(strategy : ReloadStrategy)
}
protocol OrdersViewModelInput {
    func transform(viewEvent : OrdersViewEvent)
}

protocol OrdersViewModelOutput {
    var numberOfSection : Int { get }
    var viewState: AnyPublisher<OrdersViewState, Never> { get }
    func itemFor(indexPath : IndexPath) -> OrderViewModelOutput
    func numberOfRows(section: OrderSections) -> Int
    var currentCount : Int { get }
}

enum OrderSections : Int,CaseIterable {
    case list
}

protocol OrdersViewModelProtocol: OrdersViewModelInput, OrdersViewModelOutput { }

final public class OrdersViewModel: OrdersViewModelProtocol {
    
    var viewState: AnyPublisher<OrdersViewState, Never> {
        viewStateSubject.eraseToAnyPublisher()
    }
    
    private weak var navigator: OrdersNavigatorInterface?
    private var ordersNetworkManager : OrdersNetworkManagerProtocol
    private var subscribers : Set<AnyCancellable> = .init()
    private let limit = 10
    private var offset = 0
    private var viewStateSubject : PassthroughSubject<OrdersViewState, Never> = .init()
    private var orders: [Order] = .init()
    private var isAscending = false
    private var totalCount: Int = 0
    private var isFetchingInProgress: Bool = false
    
    let dateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter
    }()
    
    let currencyFormatter = {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = .current
        return currencyFormatter
    }()
    
    init(navigator: OrdersNavigatorInterface? = nil,
         ordersNetworkManager: OrdersNetworkManagerProtocol) {
        self.navigator = navigator
        self.ordersNetworkManager = ordersNetworkManager
    }
    // MARK: - OUTPUT
    
    func itemFor(indexPath: IndexPath) -> OrderViewModelOutput {
        if indexPath.row < currentCount {
            let order = self.orders[indexPath.row]
            return OrderViewModelOutput(orderId: "#\(order.id)",
                                        usedPayment: "\(order.payment.name)",
                                        price: currencyFormatter.string(for: NSNumber(value : order.sumOriginalPrice)) ?? "",
                                        date: dateFormatter.string(from: order.updatedAt))
        } else {
            return .emptyInit
        }
    }
    
    func numberOfRows(section: OrderSections) -> Int {
        switch section {
        case .list:
            return totalCount
        }
    }
    
    var numberOfSection : Int {
        OrderSections.allCases.count
    }
    
    var currentCount: Int {
        orders.count
    }
    
    private func fecthOrders() {
        guard !isFetchingInProgress else { return }
        isFetchingInProgress = true
        ordersNetworkManager
            .fetchOrders(order: .init(limit: limit, offset: offset, sort: .updatedAt(isAscending: isAscending)))
            .sinkToResult { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .failure(let error) :
                    DispatchQueue.main.async {
                        self.isFetchingInProgress = false
                        self.viewStateSubject.send(.failed(error: error))
                    }
                case .success(let value) :
                    self.totalCount = value.meta.count
                    self.orders.append(contentsOf: value.data)
                    self.offset += value.data.count
                    let indexPathsToReload = self.calculateIndexPathsToReload(from: value.data)
                    let isFirstPage = (self.orders.count / self.limit <= 1)
                    let strategy : ReloadStrategy = isFirstPage ? .whole : .visibleItems(indexPathsToReload: indexPathsToReload)
                    DispatchQueue.main.async {
                        self.isFetchingInProgress = false
                        self.viewStateSubject.send(.loaded(strategy: strategy))
                    }
                }
            }.store(in: &subscribers)
    }
    
    private func calculateIndexPathsToReload(from newOrders: [Order]) -> [IndexPath] {
      let startIndex = orders.count - newOrders.count
      let endIndex = startIndex + newOrders.count
      return (startIndex..<endIndex).map { IndexPath(row: $0, section: OrderSections.list.rawValue) }
    }
    
}

// MARK: - INPUT. View event methods
extension OrdersViewModel {
    func transform(viewEvent: OrdersViewEvent) {
        switch viewEvent {
        case .didSelect(let indexPath) :
            navigator?.routeTo(desination: .detail(order: orders[indexPath.row]))
        case .refresh :
            offset = 0
            orders.removeAll(keepingCapacity: true)
            fallthrough
        case .viewDidLoad:
            viewStateSubject.send(.isLoading)
            fecthOrders()
        case .logout:
            KeyCahinStorage<Data>.removeAll()
            navigator?.routeTo(desination: .logout)
        case .sort:
            isAscending = !isAscending
            orders = orders.sorted(by: {self.isAscending ? $0.updatedAt < $1.updatedAt : $0.updatedAt > $1.updatedAt})
            let indexPathsToReload = (0..<offset).map { IndexPath(row: $0, section: OrderSections.list.rawValue) }
            viewStateSubject.send(.loaded(strategy: .visibleItems(indexPathsToReload: indexPathsToReload)))
        case .more :
            fecthOrders()
        }
    }
}
