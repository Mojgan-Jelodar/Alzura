//
//  OrdersViewController.swift
//  Alzura
//
//  Created by Mozhgan on 11/12/22.
//

import UIKit
import Combine

final public class OrdersViewController: UIViewController {
    private let cellIdentifer = "\(OrderView.self)"
    
    private var viewModel : OrdersViewModel!
    private var subscribers : Set<AnyCancellable> = .init()
    
    init(viewModel: OrdersViewModel!) {
        self.viewModel = viewModel
        super.init(nibName: "\(OrdersViewController.self)", bundle: nil)
    }
    
    private lazy var refreshControl : UIRefreshControl = {
        let refreshControl = UIRefreshControl(frame: .zero)
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
    private lazy var logoutButton : UIButton = {
        let logoutButton = UIButton(primaryAction: UIAction(image: .init(systemName: "pip.exit"),
                                                            handler: { [weak self] _ in
            self?.viewModel.transform(viewEvent: .logout)
        }))
        return logoutButton
    }()
    
    private lazy var sortButton : UIButton = {
        let sortButton = UIButton(primaryAction: UIAction(image: .init(systemName: "calendar.badge.clock"),
                                                          handler: { [weak self] _ in
            self?.viewModel.transform(viewEvent: .sort)
        }))
        return sortButton
    }()
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.dataSource = self
            self.tableView.delegate = self
            self.tableView.prefetchDataSource = self
            self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifer)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
        viewModel.transform(viewEvent: .viewDidLoad)
    }
    
    private func setupUI() {
        title = R.string.orders.title()
        navigationItem.leftBarButtonItem = .init(customView: logoutButton)
        navigationItem.rightBarButtonItem = .init(customView: sortButton)
        tableView.addSubview(refreshControl)
    }
    
    private func bind() {
        viewModel.viewState.sink(receiveValue: { [weak self] viewState in
            switch viewState {
            case .failed(let error):
                self?.messageLabel.text = error.localizedDescription
            case .isLoading:
                self?.messageLabel.text = R.string.orders.loadingMessage()
                self?.refreshControl.beginRefreshing()
            case .loaded(let strategy) :
                self?.messageLabel.text = ""
                self?.reload(strategy: strategy)
            }
        }).store(in: &subscribers)
    }
    
    @objc private func refresh() {
        viewModel.transform(viewEvent: .refresh)
    }
    
    private func reload(strategy : ReloadStrategy) {
        switch strategy {
        case .whole:
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
        case .visibleItems(let newIndexPathsToReload):
            let indexPathsToReload = visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
            tableView.reloadRows(at: indexPathsToReload, with: .none)
        }
    }
    
    private func shouldTryToPrefetch(indexPaths : [IndexPath]) -> Bool {
        indexPaths.contains(where: isLoadingCell(for:))
    }
    
}
private extension OrdersViewController {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= viewModel.currentCount
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}
extension OrdersViewController : UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSection
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(section: .allCases[section])
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch OrderSections.allCases[indexPath.section] {
        case .list:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath)
            cell.backgroundColor = .secondarySystemBackground
            cell.selectionStyle = .none
            cell.contentConfiguration = OrderView.Configuration(order: viewModel.itemFor(indexPath: indexPath))
            cell.isAnimated = isLoadingCell(for: indexPath)
            return cell
        }
    }
}
extension OrdersViewController : UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.transform(viewEvent: .didSelect(indexPath: indexPath))
    }
}

extension OrdersViewController : UITableViewDataSourcePrefetching {
    public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if shouldTryToPrefetch(indexPaths: indexPaths) {
            viewModel.transform(viewEvent: .more)
        }
    }
}
