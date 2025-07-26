//
//  TransactionsListView.swift
//  KBMobileBankingInterviewTest
//
//  Created by Admin on 24/07/2025.
//

import SwiftUI

struct TransactionsListView: View {
    @ObservedObject var viewModel: TransactionsListViewModel
    @State private var selectedItem: TransactionModel?

    typealias ViewID = ScreenIdentifier.ViewID

    var body: some View {
        ZStack {
            switch viewModel.state {
            case .refresh, .loading:
                    ActivityIndicator()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.accentColor)
                        .accessibilityLabel(Text("Loading transactions"))
                        .accessibilityHint(Text("Wait while transactions are loading"))
                        .accessibilityIdentifier(ViewID.loadingView.rawValue)

            case .failed:
                    ErrorView(viewModel: viewModel)
                        .accessibilityLabel(Text("Error loading transactions"))
                        .accessibilityHint(Text("An error occurred while fetching transactions"))
                        .accessibilityIdentifier(ViewID.errorView.rawValue)

            case .idle, .loaded:
                    ScrollView(.vertical) {
                        VStack(alignment: .leading, spacing: 12) {
                            Text(viewModel.title)
                                .font(.system(size: 32, weight: .bold))
                                .padding(.top)
                                .accessibilityLabel(Text(viewModel.title))
                                .accessibilityHint(Text("Title of the transaction list"))
                                .accessibilityIdentifier(ViewID.title.rawValue)

                            HStack(alignment: .center) {
                                VStack(alignment: .leading, spacing: 1) {
                                    Text(viewModel.income)
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundColor(.green)
                                        .accessibilityLabel(Text(viewModel.income))
                                        .accessibilityHint(Text("Total income"))
                                        .accessibilityIdentifier(ViewID.incomeLabel.rawValue)

                                    Text(viewModel.expenses)
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundColor(.red)
                                        .accessibilityLabel(Text(viewModel.expenses))
                                        .accessibilityHint(Text("Total expenses"))
                                        .accessibilityIdentifier(ViewID.expenseLabel.rawValue)
                                }
                                .padding(.leading, 60)
                                Spacer()
                            }

                            datePicker

                            ForEach(viewModel.filteredTransactions.indices, id: \.self) { index in
                                let transaction = viewModel.filteredTransactions[index]
                                VStack(spacing: 1) {
                                    TransactionRowView(transaction: transaction)
                                        .accessibilityElement(children: .combine)
                                        .accessibilityLabel(Text(transaction.description))
                                        .accessibilityHint(Text("Transaction details"))
                                        .accessibilityIdentifier("\(ViewID.transactionRowPrefix.rawValue)\(index)")
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
                    .accessibilityIdentifier(ViewID.mainList.rawValue)
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
                .accessibilityLabel(Text("Enable or disable date filtering"))
                .accessibilityHint(Text("Toggle to filter transactions by date"))
                .accessibilityIdentifier(ViewID.enableDateFilterToggle.rawValue)

            if viewModel.showDateFilter {
                HStack {
                    DatePicker(selection: $viewModel.startDate, displayedComponents: .date) {
                        Text("Start Date")
                            .font(.body)
                            .foregroundStyle(.secondary)
                            .accessibilityLabel(Text("Start date"))
                            .accessibilityHint(Text("Select the start date for transaction filtering"))
                    }
                    .datePickerStyle(CompactDatePickerStyle())
                    .onChange(of: viewModel.startDate, { _, _ in
                        viewModel.filterTransactions()
                    })
                    .accessibilityIdentifier(ViewID.startDatePicker.rawValue)

                    DatePicker(selection: $viewModel.endDate, displayedComponents: .date) {
                        Text("End Date")
                            .font(.body)
                            .foregroundStyle(.secondary)
                            .accessibilityLabel(Text("End date"))
                            .accessibilityHint(Text("Select the end date for transaction filtering"))
                    }
                    .datePickerStyle(CompactDatePickerStyle())
                    .onChange(of: viewModel.endDate, { _, _ in
                        viewModel.filterTransactions()
                    })
                    .accessibilityIdentifier(ViewID.endDatePicker.rawValue)
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
