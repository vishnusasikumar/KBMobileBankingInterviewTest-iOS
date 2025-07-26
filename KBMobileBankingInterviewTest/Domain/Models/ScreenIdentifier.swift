//
//  ScreenIdentifier.swift
//  KBMobileBankingInterviewTest
//
//  Created by Admin on 26/07/2025.
//

import Foundation

enum ScreenIdentifier {

    enum ViewID: String {
        case mainList
        case title
        case incomeLabel
        case expenseLabel
        case startDatePicker
        case endDatePicker
        case enableDateFilterToggle
        case transactionRowPrefix = "Transaction-" // for dynamic identifiers
        case loadingView
        case errorView
        case rowDescription
        case rowDate
        case rowAmount
    }
}
