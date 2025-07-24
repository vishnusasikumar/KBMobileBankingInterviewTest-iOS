import Foundation

struct Transaction: Identifiable {
    var id = UUID()
    var date: Date
    var description: String
    var amount: Double
}
