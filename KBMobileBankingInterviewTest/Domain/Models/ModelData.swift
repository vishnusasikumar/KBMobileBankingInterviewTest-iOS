//
//  ModelData.swift
//  KBMobileBankingInterviewTest
//
//  Created by Admin on 25/07/2025.
//

import Foundation

@Observable
class ModelData {
    var items: [TransactionModel] {
        return staticTransactions()
    }

//    let dummyData: [Transaction] = load("data.json") // Can be used to load JSON file
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
