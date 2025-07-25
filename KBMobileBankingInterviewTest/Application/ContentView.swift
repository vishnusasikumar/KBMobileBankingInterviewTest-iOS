//
//  ContentView.swift
//  KBMobileBankingInterviewTest
//
//  Created by Lucan McIver on 21/07/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            TransactionsListView(viewModel: DI.resolve(TransactionsListViewModel.self))
        }
    }
}

#Preview {
    ContentView()
}
