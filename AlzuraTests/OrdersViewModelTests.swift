//
//  AlzuraTests.swift
//  AlzuraTests
//
//  Created by Mozhgan on 11/11/22.
//

import XCTest
import Combine
@testable import Alzura

final class OrdersViewModelTests: XCTestCase {
    
    private var subjectUnderTest : OrdersViewModel!
    private var mockOrdersNavigator : MockOrdersNavigator!
    private var mockOrdersNetworkManager : MockOrdersNetworkManager!
    private var subscribers : Set<AnyCancellable>!
    override func setUpWithError() throws {
        mockOrdersNavigator = .init()
        mockOrdersNetworkManager = .init()
        subjectUnderTest = .init(navigator: mockOrdersNavigator,
                                 ordersNetworkManager: mockOrdersNetworkManager)
        subscribers = .init()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        subscribers.forEach({$0.cancel()})
        mockOrdersNavigator = nil
        mockOrdersNetworkManager = nil
        subjectUnderTest = nil
        subscribers = nil
    }
    
    func testViewDidLoad() throws {
        mockOrdersNetworkManager.value = .success(.mock)
        var outputs : [OrdersViewState] = []
        let expection = expectation(description: "Load first page")
        subjectUnderTest.viewState.sink(receiveValue: { ordersViewState in
            switch ordersViewState {
            case .isLoading:
                outputs.append(ordersViewState)
            case .failed(error: let error):
                XCTFail(error.localizedDescription)
            case .loaded:
                outputs.append(ordersViewState)
                expection.fulfill()
            }
        }).store(in: &subscribers)
        subjectUnderTest.transform(viewEvent: .viewDidLoad)
        wait(for: [expection], timeout: 2)
        XCTAssertEqual(outputs.contains(OrdersViewState.loaded(strategy: .whole)), true)
        
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
extension OrdersViewModelTests {
    class MockOrdersNavigator : OrdersNavigatorInterface {
        private(set) var to : Alzura.OrdersViewDesination?
        func routeTo(desination: Alzura.OrdersViewDesination) {
            to = desination
        }
    }
}

extension OrdersViewState : Equatable {
    public static func == (lhs: Alzura.OrdersViewState, rhs: Alzura.OrdersViewState) -> Bool {
        switch (lhs,rhs) {
        case (.isLoading,.isLoading):
            return true
        case (.failed(let lhsValue),.failed(let rhsValue)):
            return lhsValue.localizedDescription == rhsValue.localizedDescription
        case (.loaded(let lhsValue),.loaded(let rhsValue)):
            return lhsValue == rhsValue
        default :
            return false
        }
    }
}
extension ReloadStrategy : Equatable {
    public static func == (lhs: ReloadStrategy, rhs: ReloadStrategy) -> Bool {
        switch (lhs,rhs)  {
        case (.whole, .whole):
            return true
        case (.visibleItems(let lhsValue),.visibleItems(let rhsValue)):
            return lhsValue == rhsValue
        default :
            return false
        }
    }
}
