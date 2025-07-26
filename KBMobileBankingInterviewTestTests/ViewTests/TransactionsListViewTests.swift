//
//  TransactionsListViewTests.swift
//  TransactionsListViewTests
//
//  Created by Lucan McIver on 21/07/2025.
//

import XCTest
import SwiftUI
import ViewInspector

@testable import KBMobileBankingInterviewTest

// MARK: - Mock Use Case
final class MockGetTransactionsUseCase: GetTransactionsUseCaseProtocol {
    var mockTransactions: [TransactionModel] = staticTransactions()
    func getListItems() async -> [TransactionModel] {
        return mockTransactions
    }
}

final class TransactionsListViewTests: XCTestCase {

    var mockUseCase: MockGetTransactionsUseCase!
    var viewModel: TransactionsListViewModel!
    var sut: TransactionsListView!

    override func setUp() {
        super.setUp()
        // Set up the view model with mock data
        mockUseCase = MockGetTransactionsUseCase()
        viewModel = TransactionsListViewModel(getTransactionsUseCase: mockUseCase)
        sut = TransactionsListView(viewModel: viewModel)
    }

    func test_loadingState_showsActivityIndicator() throws {
        viewModel.state = .loading
        let activityIndicator = try sut.inspect().find(viewWithAccessibilityLabel: "Loading transactions")
        XCTAssertNotNil(activityIndicator, "ActivityIndicator should be shown when loading.")
    }

    func test_failedState_showsErrorView() throws {
        viewModel.state = .failed
        let errorView = try sut.inspect().find(viewWithAccessibilityLabel: "Error loading transactions")
        XCTAssertNotNil(errorView, "ErrorView should be shown when the state is failed.")
    }

    func test_transactionList_rendersCorrectly() throws {
        // Arrange: Set the state to loaded and mock data
        viewModel.state = .loaded
        viewModel.transactions = [
            TransactionModel(id: "1", date: Date(), description: "Coffee", amount: -5.0),
            TransactionModel(id: "2", date: Date(), description: "Salary", amount: 1000.0)
        ]
        viewModel.filterTransactions()

        // Act
        let scrollView = try sut.inspect().find(ViewType.ScrollView.self)
        let transactionRows = scrollView.findAll(TransactionRowView.self)

        // Assert: Verify the transaction rows exist and match the number of transactions
        XCTAssertEqual(transactionRows.count, viewModel.filteredTransactions.count, "The number of transaction rows should match the transactions count.")
    }

    func test_incomeAndExpenseText_exist() throws {
        viewModel.state = .loaded
        viewModel.transactions = [
            TransactionModel(id: "1", date: Date(), description: "Salary", amount: 2000),
            TransactionModel(id: "2", date: Date(), description: "Rent", amount: -800)
        ]
        viewModel.filterTransactions()

        let scrollView = try sut.inspect().find(ViewType.ScrollView.self)
        let incomeText = try scrollView.find(textWhere: { (text, _) in
            text.contains("Total Income")
        })
        let expenseText = try scrollView.find(textWhere: { (text, _) in
            text.contains("Total Expenses")
        })

        XCTAssertNotNil(incomeText)
        XCTAssertNotNil(expenseText)
    }

    func test_datePickers_showWhenToggleOn() throws {
        viewModel.state = .loaded
        viewModel.showDateFilter = true

        let toggle = try sut.inspect().find(ViewType.Toggle.self)
        XCTAssertEqual(try toggle.labelView().text().string(), "Enable Date Filtering")

        let startPicker = try sut.inspect().find(viewWithAccessibilityIdentifier: ScreenIdentifier.ViewID.startDatePicker.rawValue)
        let endPicker = try sut.inspect().find(viewWithAccessibilityIdentifier: ScreenIdentifier.ViewID.endDatePicker.rawValue)

        XCTAssertNotNil(startPicker)
        XCTAssertNotNil(endPicker)
    }

    func test_toggleChangesDateFiltering() throws {
        viewModel.state = .loaded
        viewModel.showDateFilter = false

        let toggle = try sut.inspect().find(ViewType.Toggle.self)
        try toggle.tap()
        XCTAssertTrue(viewModel.showDateFilter, "The date filter should be enabled after toggling.")
    }
}
