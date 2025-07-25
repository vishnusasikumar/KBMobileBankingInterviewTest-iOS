// swiftlint:disable:this file_name
//  TestUtils.swift
//  KBMobileBankingInterviewTestTests
//
//  Created by Admin on 25/07/2025.
//

import Foundation
import Testing

protocol FetchMockJson {
    func loadMockResponse(with fileName: String) throws -> Data?
    func decodeJson<T: Decodable>(from fileName: String) throws -> T?
}

extension FetchMockJson {
    func loadMockResponse(with fileName: String) throws -> Data? {
        let url = try #require(Bundle.main.url(forResource: fileName, withExtension: "json"), "JSON file should be found")
        let data = try Data(contentsOf: url)
        return data
    }

    func decodeJson<T: Decodable>(from fileName: String) throws -> T? {
        let data = try #require(try loadMockResponse(with: fileName))
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let jsonData: T = try decoder.decode(T.self, from: data)
        return jsonData
    }
}
// swiftlint:enable file_name
