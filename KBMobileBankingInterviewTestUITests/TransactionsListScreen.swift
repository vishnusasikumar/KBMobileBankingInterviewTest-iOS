//
//  TransactionsListScreen.swift
//  KBMobileBankingInterviewTest
//
//  Created by Admin on 26/07/2025.
//

import XCTest

class TransactionsListScreen {

    private let app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
    }

    var titleLabel: XCUIElement {
        app.staticTexts[ScreenIdentifier.ViewID.title.rawValue]
    }

    var incomeLabel: XCUIElement {
        app.staticTexts[ScreenIdentifier.ViewID.incomeLabel.rawValue]
    }

    var expenseLabel: XCUIElement {
        app.staticTexts[ScreenIdentifier.ViewID.expenseLabel.rawValue]
    }

    var list: XCUIElement {
        app.scrollViews[ScreenIdentifier.ViewID.mainList.rawValue]
    }

    var income: XCUIElement {
        app.staticTexts[ScreenIdentifier.ViewID.incomeLabel.rawValue]
    }

    var toggle: XCUIElement {
        app.switches[ScreenIdentifier.ViewID.enableDateFilterToggle.rawValue]
    }

    func getTransactionRow(with description: String) -> XCUIElement {
        app.staticTexts["\(ScreenIdentifier.ViewID.transactionRowPrefix.rawValue)\(description)"]
    }

    var startDatePicker: XCUIElement {
        app.datePickers[ScreenIdentifier.ViewID.startDatePicker.rawValue]
    }

    var endDatePicker: XCUIElement {
        app.datePickers[ScreenIdentifier.ViewID.endDatePicker.rawValue]
    }

    var loadingIndicator: XCUIElement {
        app.otherElements[ScreenIdentifier.ViewID.loadingView.rawValue]
    }
}
