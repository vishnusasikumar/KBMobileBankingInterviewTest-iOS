//
//  TransactionsListView.swift
//  KBMobileBankingInterviewTest
//
//  Created by Admin on 24/07/2025.
//

import SwiftUI

struct TransactionsListView: View {
    @ObservedObject var viewModel: TransactionsListViewModel
    @State private var selectedItem: Transaction?

    var body: some View {
        ZStack {
            switch viewModel.state {
            case .refresh, .loading:
                    ActivityIndicator()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.accentColor)
            case .failed:
                    ErrorView(viewModel: viewModel)
            case .idle, .loaded:
                    ScrollView(.vertical) {
                        VStack(alignment: .leading, spacing: 12) {
                            Text(viewModel.title)
                                .font(.system(size: 32, weight: .bold))
                                .padding(.top)
                            HStack(alignment: .center) {
                                VStack(alignment: .leading, spacing: 1) {
                                    Text(viewModel.income)
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundColor(.green)
                                    Text(viewModel.expenses)
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundColor(.red)
                                }
                                .padding(.leading, 60)
                                Spacer()
                            }

                            datePicker

                            ForEach(viewModel.filteredTransactions) { transaction in
                                VStack(spacing: 1) {
                                    TransactionRowView(transaction: transaction)
                                }
                                .tag(transaction.description)
                                .listRowSeparator(.hidden)
                            }
                        }
                    }
                    .padding(10)
                    .refreshable {
                        await viewModel.refresh()
                    }
                    .animation(.default, value: viewModel.transactions)
                    .navigationTitle(viewModel.title)
                    .accessibilityLabel(Text("List of transactions"))
                    .accessibilityHint(Text("Show a list of transactions"))
                    .accessibilityIdentifier(TransactionsListViewModel.ViewID.mainList.rawValue)
            }
        }
        .onAppear {
            Task {
                await viewModel.getNextItems()
            }
        }
    }

    private var datePicker: some View {
        Group {
            Toggle("Enable Date Filtering", isOn: $viewModel.showDateFilter)
                .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                .padding()

            if viewModel.showDateFilter {
                HStack {
                    DatePicker(selection: $viewModel.startDate, displayedComponents: .date) {
                        Text("Start Date")
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }
                    .datePickerStyle(CompactDatePickerStyle())
                    .onChange(of: viewModel.startDate, { _, _ in
                        viewModel.filterTransactions()
                    })

                    DatePicker(selection: $viewModel.endDate, displayedComponents: .date) {
                        Text("End Date")
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }
                    .datePickerStyle(CompactDatePickerStyle())
                    .onChange(of: viewModel.endDate, { _, _ in
                        viewModel.filterTransactions()
                    })
                }
                .padding(.horizontal)
                .padding(.bottom)
                .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
        }
    }
}

#Preview {
    TransactionsListView(viewModel: DI.resolve(TransactionsListViewModel.self))
}
