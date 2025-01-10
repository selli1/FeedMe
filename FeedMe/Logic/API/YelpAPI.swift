//
//  YelpAPI.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/6/25.
//

import Foundation

class YelpAPI: YelpDataProvider {
    
    private let baseURL: String = "https://api.yelp.com/v3/"
    private let apiKey: String = "Bearer X8_keRfw6exoxK0eE7QWNtei-nprGTRg3O7kl8xsSSYPUOMSr6SvQNbl8PrPnkCUGgbF_BFGPjWzuq4CEvR07mMs0uLXsCRjYIVEDn3ZkhgseAom5ZARnb3xTvl7Z3Yx"
    private let decoder = Decoder()
    
    func searchBusinesses(_ location: Coordinates) async throws -> BusinessSearchResponse {
        let urlString = baseURL + "businesses/search"
        guard var url = URL(string: urlString) else { throw URLError(.badURL) }
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "latitude", value: "\(location.latitude)"),
            URLQueryItem(name: "longitude", value: "\(location.longitude)"),
            URLQueryItem(name: "limit", value: "50")
        ]
        url.append(queryItems: queryItems)

        let request = prepareRequest(url)
        let (data, response) = try await URLSession.shared.data(for: request)
        if let response = response as? HTTPURLResponse, response.statusCode != 200 {
            throw ServerError(response.statusCode)
        } else {
            return try decoder.decode(BusinessSearchResponse.self, from: data)
        }
    }
    
    private func prepareRequest(_ url: URL, method: HTTPMethod = .get) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
          "accept": "application/json",
          "Authorization": "\(apiKey)"
        ]
        return request
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum ServerError: Error {
    case invalidRequest
    case unauthorized
    case authorizationError
    case resourceNotFound
    case payloadTooLarge
    case rateLimited
    case internalServerError
    case serviceUnavailable
    case unknownError(code: Int)
    
    init(_ statusCode: Int) {
        switch statusCode {
        case 400:
            self = .invalidRequest
        case 401:
            self = .unauthorized
        case 403:
            self = .authorizationError
        case 404:
            self = .resourceNotFound
        case 413:
            self = .payloadTooLarge
        case 429:
            self = .rateLimited
        case 500:
            self = .internalServerError
        case 503:
            self = .serviceUnavailable
        default:
            self = .unknownError(code: statusCode)
        }
    }
}



