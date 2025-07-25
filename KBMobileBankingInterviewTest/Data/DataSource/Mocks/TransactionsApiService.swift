import Foundation

class TransactionsApiService: NetworkServiceProtocol {
    public func request<T: Decodable>() async throws -> Result<T, APIError> {
        // Simulate a network delay
        try? await Task.sleep(nanoseconds: 2 * 1_000_000_000) // 2 seconds
        if let transactions = staticTransactions() as? T {
            return .success(transactions)
        } else {
            throw APIError.error_400
        }
    }

    func cancelAllTasks() {
        // mock cancel all session tasks
    }
}

public func staticTransactions() -> [Transaction] {

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"

    func createDate(from dateString: String) -> Date {
        guard let date = dateFormatter.date(from: dateString) else {
            fatalError("Failed to parse date string: \(dateString)")
        }
        return date
    }

    return [
        Transaction(date: createDate(from: "2025-07-22"), description: "Restaurant", amount: -35.00),
        Transaction(date: createDate(from: "2025-07-24"), description: "Car Repair", amount: -150.00),
        Transaction(date: createDate(from: "2025-07-11"), description: "Utilities", amount: -150.00),
        Transaction(date: createDate(from: "2025-07-19"), description: "Clothing Store", amount: -100.00),
        Transaction(date: createDate(from: "2025-07-12"), description: "Car Repair", amount: -200.00),
        Transaction(date: createDate(from: "2025-07-13"), description: "Book Purchase", amount: -30.00),
        Transaction(date: createDate(from: "2025-07-14"), description: "Electronics", amount: -500.00),
        Transaction(date: createDate(from: "2025-07-17"), description: "Groceries", amount: -70.00),
        Transaction(date: createDate(from: "2025-07-26"), description: "Electronics", amount: -300.00),
        Transaction(date: createDate(from: "2025-07-18"), description: "Gym Membership", amount: -50.00),
        Transaction(date: createDate(from: "2025-07-01"), description: "Coffee Shop", amount: -15.00),
        Transaction(date: createDate(from: "2025-07-02"), description: "Grocery Store", amount: -75.00),
        Transaction(date: createDate(from: "2025-07-05"), description: "Clothing Store", amount: -120.00),
        Transaction(date: createDate(from: "2025-07-06"), description: "Gym Membership", amount: -50.00),
        Transaction(date: createDate(from: "2025-07-30"), description: "Gym Membership", amount: -50.00),
        Transaction(date: createDate(from: "2025-07-15"), description: "Vacation", amount: -1500.00),
        Transaction(date: createDate(from: "2025-07-07"), description: "Movie Tickets", amount: -30.00),
        Transaction(date: createDate(from: "2025-07-08"), description: "Salary", amount: 2500.00),
        Transaction(date: createDate(from: "2025-07-09"), description: "Groceries", amount: -80.00),
        Transaction(date: createDate(from: "2025-07-23"), description: "Groceries", amount: -90.00),
        Transaction(date: createDate(from: "2025-07-10"), description: "Rent", amount: -1200.00),
        Transaction(date: createDate(from: "2025-07-20"), description: "Movie Tickets", amount: -25.00),
        Transaction(date: createDate(from: "2025-07-21"), description: "Gas Station", amount: -55.00),
        Transaction(date: createDate(from: "2025-07-25"), description: "Utilities", amount: -120.00),
        Transaction(date: createDate(from: "2025-07-27"), description: "Vacation", amount: -1000.00),
        Transaction(date: createDate(from: "2025-07-28"), description: "Restaurant", amount: -45.00),
        Transaction(date: createDate(from: "2025-07-29"), description: "Groceries", amount: -85.00),
        Transaction(date: createDate(from: "2025-07-16"), description: "Restaurant", amount: -40.00),
        Transaction(date: createDate(from: "2025-07-03"), description: "Restaurant", amount: -35.00),
        Transaction(date: createDate(from: "2025-07-04"), description: "Gas Station", amount: -60.00)
    ]
}
