//
//  DI.swift
//  KBMobileBankingInterviewTest
//
//  Created by Admin on 24/07/2025.
//

import Foundation
import Swinject

// MARK: - Dependency Injection
enum DI {
    private static let container = Container()
    private static let assembler = Assembler(container: container)

    static func assemble(assemblies: [Assembly]) {
        assembler.apply(assemblies: assemblies)
    }

    static var resolver: Resolver {
        assembler.resolver
    }

    static func resolve<T>(_ type: T.Type) -> T {
        guard let service = assembler.resolver.resolve(type) else {
            fatalError("Type \(type) is not registered")
        }
        return service
    }

    @discardableResult
    static func register<Service>(
        _ serviceType: Service.Type,
        name: String? = nil,
        factory: @escaping (Resolver) -> Service
    ) -> ServiceEntry<Service> {
        return container.register(serviceType, name: name, factory: factory)
    }
}
