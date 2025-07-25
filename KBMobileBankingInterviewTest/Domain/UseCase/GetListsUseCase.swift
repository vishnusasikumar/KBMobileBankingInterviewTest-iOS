//
//  GetListsUseCase.swift
//  KBMobileBankingInterviewTest
//
//  Created by Admin on 25/07/2025.
//

import Foundation

protocol GetTransactionsUseCaseProtocol {
    func getListItems() async -> [TransactionModel]
}

struct GetListsUseCase: GetTransactionsUseCaseProtocol {
    var repo: TransactionsRepositoryProtocol

    func getListItems() async -> [TransactionModel] {
        do {
            return try await repo.getTransactions()
        } catch let error {
            debugPrint(error)
            return []
        }
    }
}
