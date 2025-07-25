//
//  UseCaseAssembly.swift
//  KBMobileBankingInterviewTest
//
//  Created by Admin on 25/07/2025.
//

import Foundation
import Swinject
import SwinjectAutoregistration

struct UseCaseAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        container.autoregister(GetTransactionsUseCaseProtocol.self, initializer: GetListsUseCase.init)
    }
}
