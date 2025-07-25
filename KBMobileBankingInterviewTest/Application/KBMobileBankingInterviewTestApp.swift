//
//  KBMobileBankingInterviewTestApp.swift
//  KBMobileBankingInterviewTest
//
//  Created by Lucan McIver on 21/07/2025.
//

import SwiftUI

@main
struct KBMobileBankingInterviewTestApp: App {

    init() {
        DI.assemble(assemblies: AppDIAssembly.all)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
        }
    }
}
