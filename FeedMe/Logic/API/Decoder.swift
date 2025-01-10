//
//  Decoder.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/10/25.
//

import Foundation

class Decoder {
    private let decoder = JSONDecoder()
    
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        do {
            return try decoder.decode(type, from: data)
        } catch let error as DecodingError {
            printDecodingError(error, for: data)
            throw error
        } catch {
            throw error
        }
    }
    
    private func printDecodingError(_ error: DecodingError, for data: Data) {
        switch error {
        case.keyNotFound(let key, let context):
            print("Decoding error (keyNotFound): \(key) not found in \(context.debugDescription)")
            print("Coding path: \(context.codingPath)")
        case.dataCorrupted(let context):
            print("Decoding error (dataCorrupted): data corrupted in \(context.debugDescription)")
            print("Coding path: \(context.codingPath)")
        case.typeMismatch(let type, let context):
            print("Decoding error (typeMismatch): type mismatch of \(type) in \(context.debugDescription)")
            print("Coding path: \(context.codingPath)")
        case.valueNotFound(let type, let context):
            print("Decoding error (valueNotFound): value not found for \(type) in \(context.debugDescription)")
            print("Coding path: \(context.codingPath)")
        default: break
        }
        guard let dataString = String(data: data, encoding: String.Encoding.utf8) else { return }
        print("Received data:")
        print(dataString)
    }
}
