//
//  ViewModelAssembly.swift
//  KBMobileBankingInterviewTest
//
//  Created by Admin on 25/07/2025.
//

import Foundation
import Swinject
import SwinjectAutoregistration

struct ViewModelAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        container.autoregister(TransactionsListViewModel.self, initializer: TransactionsListViewModel.init)
    }
}
