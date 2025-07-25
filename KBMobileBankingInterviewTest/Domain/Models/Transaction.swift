import Foundation

public struct Transaction: Hashable, Decodable, Identifiable {
    public var id = UUID()
    public var date: Date
    public var description: String
    public var amount: Double
}
