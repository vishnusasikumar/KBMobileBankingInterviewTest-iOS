import Foundation

public struct TransactionModel: Hashable, Decodable, Identifiable {
    public var id: String
    public let date: Date
    public let description: String
    public let amount: Double

    enum CodingKeys: String, CodingKey {
        case id
        case date
        case description
        case amount
    }

    public init(id: String = UUID().uuidString, date: Date, description: String, amount: Double) {
        self.id = id
        self.date = date
        self.description = description
        self.amount = amount
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString

        let dateString = try container.decode(String.self, forKey: .date)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd" // Adjust this format based on your date string format

        guard let date = formatter.date(from: dateString) else {
            throw DecodingError.dataCorruptedError(forKey: .date, in: container, debugDescription: "Invalid date format.")
        }
        self.date = date

        self.description = try container.decode(String.self, forKey: .description)
        self.amount = try container.decode(Double.self, forKey: .amount)
    }
}
