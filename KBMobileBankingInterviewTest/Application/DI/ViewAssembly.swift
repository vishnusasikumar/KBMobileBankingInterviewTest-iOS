//
//  ViewAssembly.swift
//  KBMobileBankingInterviewTest
//
//  Created by Admin on 24/07/2025.
//

import Foundation
import Swinject
import SwinjectAutoregistration

struct ViewAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        container.autoregister(TransactionsListView.self, initializer: TransactionsListView.init)
    }
}
