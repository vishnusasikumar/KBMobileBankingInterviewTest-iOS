//
//  TransactionsListViewUITests.swift
//  KBMobileBankingInterviewTestUITests
//
//  Created by Lucan McIver on 21/07/2025.
//

import XCTest

final class TransactionsListViewUITests: XCTestCase {

    private var app: XCUIApplication!

    private var screen: TransactionsListScreen {
        TransactionsListScreen(app: app)
    }

    override func setUp() {
        super.setUp()
        app = .init()
        app.launch()
    }

    override func tearDown() {
        super.tearDown()
        app = nil
    }

    @MainActor
    func testTitleAndIncomeExpenseLabels() throws {
        XCTAssertEqual(screen.titleLabel.label, "Transactions", "Title text is incorrect.")
        XCTAssertTrue(screen.incomeLabel.exists, "The income label should be present.")
        XCTAssertTrue(screen.expenseLabel.exists, "The expense label should be present.")
    }

    @MainActor
    func testEnableDateFilterToggle() throws {
        let toggle = screen.toggle

        XCTAssertTrue(toggle.waitForExistence(timeout: 3), "The date filter toggle should be present.")
        XCTAssertEqual(toggle.value as? String, "0", "The toggle should be off by default.")

        toggle.tap()
        XCTAssertEqual(toggle.value as? String, "1", "The toggle should be on after tapping.")
    }

    @MainActor
    func testDatePickersAppearWhenEnabled() throws {
        screen.toggle.tap()

        XCTAssertTrue(screen.startDatePicker.exists, "The Start Date picker should appear when the date filter is enabled.")
        XCTAssertTrue(screen.endDatePicker.exists, "The End Date picker should appear when the date filter is enabled.")
    }

    @MainActor
    func testTransactionRowAccessibility() throws {
        let transactionRow = screen.getTransactionRow(with: "2")
        XCTAssertTrue(transactionRow.waitForExistence(timeout: 3), "The transaction row should be accessible.")

        let transactionDescription = transactionRow.staticTexts[ScreenIdentifier.ViewID.rowDescription.rawValue]
        let transactionDate = transactionRow.staticTexts[ScreenIdentifier.ViewID.rowDate.rawValue]
        let transactionAmount = transactionRow.staticTexts[ScreenIdentifier.ViewID.rowAmount.rawValue]

        XCTAssertTrue(transactionDescription.exists, "The transaction description should be visible.")
        XCTAssertTrue(transactionDate.exists, "The transaction date should be visible.")
        XCTAssertTrue(transactionAmount.exists, "The transaction amount should be visible.")
    }

    @MainActor
    func testLoadingAction() throws {
        // Perform the pull-to-refresh gesture
        let startCoordinate = screen.list.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.0))
        let endCoordinate = screen.list.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.4)) // Pull down by 40% of the list height

        startCoordinate.press(forDuration: 0.1, thenDragTo: endCoordinate)
        // Wait for the loading indicator to appear and be visible
        let exists = screen.loadingIndicator.waitForExistence(timeout: 3)
        XCTAssertTrue(exists, "The refresh indicator should appear when the list is refreshed.")

        // Wait for it to be visible (add an additional check for visibility)
        XCTAssertTrue(screen.loadingIndicator.isHittable, "The refresh indicator should be visible and hittable.")

        // Wait for the indicator to disappear
        XCTAssertFalse(screen.loadingIndicator.waitForExistence(timeout: 2), "The refresh indicator should disappear after 2 seconds.")
    }
}
