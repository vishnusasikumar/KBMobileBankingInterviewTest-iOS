//
//  ViewModelTests.swift
//  KBMobileBankingInterviewTestTests
//
//  Created by Admin on 25/07/2025.
//

import Testing
import Foundation
@testable import KBMobileBankingInterviewTest

struct MockListUseCase: GetTransactionsUseCaseProtocol {
    var transactions: [TransactionModel] = []
    var error: APIError?

    init(transactions: [TransactionModel], error: APIError? = nil) {
        self.transactions = transactions
        self.error = error
    }

    func getListItems() async -> [TransactionModel] {
        try? await Task.sleep(nanoseconds: 2 * 1_000_000_000) // 2 seconds
        if error != nil {
            return []
        }
        return transactions
    }
}

@Suite("ViewModel protocol tests") struct ViewModelTests: FetchMockJson {
    var useCase: GetTransactionsUseCaseProtocol
    var viewModel: TransactionsListViewModel

    init() async throws {
        useCase = MockListUseCase(transactions: [])
        viewModel = TransactionsListViewModel(getTransactionsUseCase: useCase)
    }

    @Test("ViewModel successfully generated transactions data") mutating func getNextItemsSuccess() async throws {
        let result: [TransactionModel] = try #require(try decodeJson(from: "KBMockResponse"))
        useCase = MockListUseCase(transactions: result)
        viewModel = TransactionsListViewModel(getTransactionsUseCase: useCase)
        await viewModel.getNextItems()
        #expect(viewModel.state == .loaded, "ViewModel should set the state to loaded")
        #expect(!viewModel.filteredTransactions.isEmpty, "ViewModel should return values")
        try #require(viewModel.transactions.count == viewModel.filteredTransactions.count, "Transactions count should match")
    }

    @Test("ViewModel failed to generate data") mutating func getNextItemsFailure() async throws {
        useCase = MockListUseCase(transactions: [], error: APIError.errorDecode)
        await viewModel.getNextItems()
        #expect(viewModel.filteredTransactions.isEmpty, "ViewModel should return empty")
    }

    @Test("ViewModel successfully generated transactions data") mutating func filterTransactionsSuccess() async throws {
        try await getNextItemsSuccess()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let startDate = dateFormatter.date(from: "2025-07-01")
        viewModel.startDate = try #require(startDate, "Start Date should return 1 July 2025")

        let endDate = dateFormatter.date(from: "2025-07-03")
        viewModel.endDate = try #require(endDate, "End Date should return 3 July 2025")

        viewModel.showDateFilter = true
        #expect(viewModel.filteredTransactions.count == 3, "After filter transactions count should be 3")
    }
}
