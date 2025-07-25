//
//  Date+Extension.swift
//  KBMobileBankingInterviewTest
//
//  Created by Admin on 25/07/2025.
//

import Foundation

extension Date: @retroactive RawRepresentable {
    private static let formatter = ISO8601DateFormatter()

    static var timeZone: TimeZone {
        if let timeZone = TimeZone(identifier: TimeZone.current.identifier) {
            return timeZone
        } else {
            fatalError("Invalid time zone identifier")
        }
    }

    public var rawValue: String {
        Date.formatter.string(from: self)
    }

    public init?(rawValue: String) {
        self = Date.formatter.date(from: rawValue) ?? Date()
    }

    private func string(withFormat format: String, locale: Locale? = nil,
                        timeZone: TimeZone? = nil, smallAmPm: Bool = true) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        if let tz = timeZone {
            formatter.timeZone = tz
        }
        formatter.amSymbol = smallAmPm ? "am" : "AM"
        formatter.pmSymbol = smallAmPm ? "pm" : "PM"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: self)
    }

    var yearMonthDayHyphenated: String { return string(withFormat: "yyyy-MM-dd") }

    func getDateString() -> String {
        string(withFormat: "dd MMM yyyy")
    }
}
