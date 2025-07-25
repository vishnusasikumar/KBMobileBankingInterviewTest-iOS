//
//  RepositoryAssembly.swift
//  KBMobileBankingInterviewTest
//
//  Created by Admin on 25/07/2025.
//

import Foundation
import Swinject
import SwinjectAutoregistration

struct RepositoryAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        container.autoregister(TransactionsRepositoryProtocol.self, initializer: TransactionsRepository.init)
    }
}
