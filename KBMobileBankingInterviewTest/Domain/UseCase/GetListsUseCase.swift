//
//  GetListsUseCase.swift
//  KBMobileBankingInterviewTest
//
//  Created by Admin on 25/07/2025.
//

import Foundation

protocol GetListsUseCaseProtocol {
    func getListItems() async -> [Transaction]
}

struct GetListsUseCase: GetListsUseCaseProtocol {
    var repo: TransactionsRepositoryProtocol

    func getListItems() async -> [Transaction] {
        do {
            return try await repo.getTransactions()
        } catch let error {
            debugPrint(error)
            return []
        }
    }
}
