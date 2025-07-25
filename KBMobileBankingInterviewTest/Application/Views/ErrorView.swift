//
//  ErrorView.swift
//  KBMobileBankingInterviewTest
//
//  Created by Admin on 25/07/2025.
//

import SwiftUI

struct ErrorView: View {
    @ObservedObject var viewModel: TransactionsListViewModel

    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .overlay {
                VStack {
                    Text("Sorry something went wrong, Please try again later")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    Button("Reload Users") {
                        Task {
                            await viewModel.refresh()
                        }
                    }
                    .buttonStyle(.bordered)
                }

            }
    }
}

#Preview {
    ErrorView(viewModel: DI.resolve(TransactionsListViewModel.self))
}
