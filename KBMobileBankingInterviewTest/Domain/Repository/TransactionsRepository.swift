//
//  TransactionsRepository.swift
//  KBMobileBankingInterviewTest
//
//  Created by Admin on 24/07/2025.
//

import Foundation

protocol TransactionsRepositoryProtocol {
    func getTransactions() async throws -> [TransactionModel]
}

struct TransactionsRepository: TransactionsRepositoryProtocol {
    private let service: NetworkServiceProtocol

    init(service: NetworkServiceProtocol) {
        self.service = service
    }

    func getTransactions() async throws -> [TransactionModel] {
        do {
            let result: Result<[TransactionModel], APIError> = try await service.request()
            switch result {
            case .success(let items):
                return items
            case .failure(let error):
                throw APIError.failed(error: error)
            }
        } catch let error {
            throw APIError.failed(error: error)
        }
    }
}
