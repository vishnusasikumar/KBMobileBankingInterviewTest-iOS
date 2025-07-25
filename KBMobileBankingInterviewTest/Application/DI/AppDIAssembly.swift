//
//  AppDIAssembly.swift
//  KBMobileBankingInterviewTest
//
//  Created by Admin on 24/07/2025.
//

import Foundation
import Swinject

enum AppDIAssembly {
    static var all: [Assembly] {
        [
            ApiServicesAssembly(),
            RepositoryAssembly(),
            UseCaseAssembly(),
            ViewModelAssembly(),
            ViewAssembly()
        ]
    }
}
