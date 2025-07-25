//
//  RepositoryTests.swift
//  KBMobileBankingInterviewTestTests
//
//  Created by Admin on 25/07/2025.
//

import Testing
import Foundation
@testable import KBMobileBankingInterviewTest

class MockNetworkService: NetworkServiceProtocol {

    var result: Data?
    var error: APIError?
    var responseCode: Int

    init(result: Data? = nil, error: APIError? = nil, responseCode: Int = 200) {
        self.result = result
        self.error = error
        self.responseCode = responseCode
    }

    func request<T: Decodable>() async throws -> Result<T, APIError> {
        try? await Task.sleep(nanoseconds: 2 * 1_000_000_000) // 2 seconds
        if let result {
            guard let response = HTTPURLResponse(url: Constants.urlComponents.url!, statusCode: responseCode, httpVersion: nil, headerFields: nil) else {
                throw APIError.error_500
            }
            return try await completionHandler(result, response)
        } else {
            if let error {
                throw error
            } else {
                throw APIError.error_500
            }
        }
    }

    func cancelAllTasks() {
        // Empty conformance of protocol
    }
}

@Suite("Repository protocol tests") struct RepositoryTests: FetchMockJson {

    var mockNetworService: NetworkServiceProtocol!
    var repository: TransactionsRepository!

    init() async throws {
        mockNetworService = MockNetworkService()
        repository = TransactionsRepository(service: mockNetworService)
    }

    @Test("Repository successfully fetches data") mutating func repositoryFetchSuccess() async throws {
        let data = try #require(try loadMockResponse(with: "KBMockResponse"), "Result mocks need to be fetched")
        mockNetworService = MockNetworkService(result: data)
        repository = TransactionsRepository(service: mockNetworService)
        let itemsArray = try await repository.getTransactions()
        #expect(!itemsArray.isEmpty, "Repository should return a value")
    }

    @Test("Repository failed to fetch data") mutating func repositoryFetchFailure() async throws {
        mockNetworService = MockNetworkService(result: nil, error: APIError.error_204, responseCode: 204)
        repository = TransactionsRepository(service: mockNetworService)
        await #expect(throws: APIError.self, "Repository should throw an error") {
            try await repository.getTransactions()
        }
    }
}
