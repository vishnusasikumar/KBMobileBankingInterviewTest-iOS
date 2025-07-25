//
//  ApiServicesAssembly.swift
//  KBMobileBankingInterviewTest
//
//  Created by Admin on 25/07/2025.
//

import Foundation
import Swinject
import SwinjectAutoregistration

struct ApiServicesAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        container.autoregister(NetworkServiceProtocol.self, initializer: { NetworkService() })
        container.autoregister(NetworkServiceProtocol.self, initializer: TransactionsApiService.init)
    }
}
