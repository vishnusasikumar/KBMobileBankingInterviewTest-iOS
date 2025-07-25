// swiftlint:disable:this file_name
//  NetworkProtocol+extensions.swift
//  KBMobileBankingInterviewTest
//
//  Created by Admin on 25/07/2025.
//

import Foundation

public protocol CompletionHandler {
    func completionHandler<T: Decodable>(_ data: Data?, _ response: HTTPURLResponse) async throws -> Result<T, APIError>
}

extension CompletionHandler {
    func completionHandler<T: Decodable>(_ data: Data?, _ response: HTTPURLResponse) async throws -> Result<T, APIError> {
        if let data = data {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let model = json as? AnyHashable {
                    let decoder = JSONDecoder()
                    do {
                        let data1 = try JSONSerialization.data(withJSONObject: model, options: .prettyPrinted)
                        let value = try decoder.decode(T.self, from: data1)
                        return .success(value)
                    } catch let error {
                        throw APIError.failed(error: error)
                    }
                }
            } catch let error {
                let statusCode = response.statusCode
                switch NetworkStatus(rawValue: statusCode) {
                case .noContent:
                    // Manage 204 code.
                    throw APIError.error_204
                case .unauthorized:
                    // Manage 401 erorr code.
                    throw APIError.error_401
                case .badRequest:
                    // Manage 400 erorr code.
                    throw APIError.error_400
                case .notFound:
                    // Manage 404 error.
                    throw APIError.error_404
                case .forbidden:
                    throw APIError.failed(error: error)
                default:
                    // Manage unknow erorr code.
                    throw APIError.failed(error: error)
                }
            }

        }
        throw APIError.error_204
    }
}
// swiftlint:enable file_name
