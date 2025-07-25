//
//  TransactionsListViewModel.swift
//  KBMobileBankingInterviewTest
//
//  Created by Admin on 24/07/2025.
//

import Foundation

class TransactionsListViewModel: ObservableObject {

    enum ViewState {
        case idle
        case loading
        case loaded
        case failed
        case refresh
    }

    enum ViewID: String {
        case mainList
        case refreshButton
    }

    @Published private(set) var transactions: [Transaction] = []
    @Published private(set) var state = ViewState.idle
    @Published var showDateFilter = false {
        didSet {
            filterTransactions()
        }
    }

    @Published var filteredTransactions: [Transaction] = []
    @Published var startDate: Date = Date()
    @Published var endDate: Date = Date()

    private var getItemsUseCase: GetListsUseCaseProtocol

    init(getItemsUseCase: GetListsUseCaseProtocol) {
        self.getItemsUseCase = getItemsUseCase
    }

    @MainActor
    func getNextItems() async {
        state = .loading
        Task {
            let array = await getItemsUseCase.getListItems()
            if array.isEmpty {
                self.state = .failed
            } else {
                self.transactions = array
                filterTransactions()
                self.state = .loaded
            }
        }
    }

    @MainActor
    func refresh() async {
        await getNextItems()
    }

    func filterTransactions() {
        if !showDateFilter || checkDates() {
            filteredTransactions = transactions
                .sorted { $0.date < $1.date }
            return
        }
        filteredTransactions = transactions.filter { transaction in
            transaction.date >= startDate && transaction.date <= endDate
        }.sorted { $0.date < $1.date }
    }

    // Function to check if the start and end dates are the same as the current date
    private func checkDates() -> Bool {
        let currentDate = Date()
        // Remove time components for comparison (compare only the date part)
        let calendar = Calendar.current
        let startDay = calendar.startOfDay(for: startDate)
        let endDay = calendar.startOfDay(for: endDate)
        let currentDay = calendar.startOfDay(for: currentDate)

        return startDay == currentDay && endDay == currentDay
    }

    var title: String {
        "Transactions"
    }

    var income: String {
        "Total Income: " +
        filteredTransactions
            .filter { $0.amount > 0 }
            .reduce(0) { $0 + $1.amount }
            .formatted(.currency(code: "NZD"))
    }

    var expenses: String {
        "Total Expenses: " +
        filteredTransactions
            .filter { $0.amount < 0 }
            .reduce(0) { $0 + $1.amount }
            .formatted(.currency(code: "NZD"))
    }
}
