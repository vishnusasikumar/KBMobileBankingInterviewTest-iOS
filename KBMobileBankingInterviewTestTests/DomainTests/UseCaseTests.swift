//
//  UseCaseTests.swift
//  KBMobileBankingInterviewTestTests
//
//  Created by Admin on 25/07/2025.
//

import Testing
import Foundation
@testable import KBMobileBankingInterviewTest

struct MockListRepository: TransactionsRepositoryProtocol {
    var transactions: [TransactionModel]?
    var error: APIError?

    init(transactions: [TransactionModel]? = nil, error: APIError? = nil) {
        self.transactions = transactions
        self.error = error
    }

    func getTransactions() async throws -> [TransactionModel] {
        try? await Task.sleep(nanoseconds: 2 * 1_000_000_000) // 2 seconds
        if let transactions {
            return transactions
        } else {
            if let error {
                throw APIError.failed(error: error)
            }
        }
        throw APIError.unknownError
    }
}

@Suite("UseCase protocol tests") struct UseCaseTests: FetchMockJson {

    var repository: TransactionsRepositoryProtocol
    var useCase: GetListsUseCase

    init() async throws {
        repository = MockListRepository()
        useCase = GetListsUseCase(repo: repository)
    }

    @Test("UseCase successfully fetches data") mutating func useCaseFetchSuccess() async throws {
        let result: [TransactionModel] = try #require(try decodeJson(from: "KBMockResponse"))
        repository = MockListRepository(transactions: result)
        useCase = GetListsUseCase(repo: repository)
        let items = await useCase.getListItems()
        #expect(!items.isEmpty, "UseCase should return values")
    }

    @Test("UseCase failed to fetch data") mutating func useCaseFetchFailure() async throws {
        repository = MockListRepository(transactions: nil, error: APIError.errorDecode)
        useCase = GetListsUseCase(repo: repository)
        let items = await useCase.getListItems()
        #expect(items.isEmpty, "UseCase should throw an error")
    }
}
