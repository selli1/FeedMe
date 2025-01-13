//
//  YelpAPI.swift
//  FeedMe
//
//  Created by Steven Elliott on 1/6/25.
//

import Foundation

// API class for interacting with the Yelp API
class YelpAPI: YelpDataProvider {
    private let baseURL: String = "https://api.yelp.com/v3/"
    private let apiKey: String = "Bearer X8_keRfw6exoxK0eE7QWNtei-nprGTRg3O7kl8xsSSYPUOMSr6SvQNbl8PrPnkCUGgbF_BFGPjWzuq4CEvR07mMs0uLXsCRjYIVEDn3ZkhgseAom5ZARnb3xTvl7Z3Yx"
    
    private let decoder = Decoder()
    
    // Implementing the required searchBusiness by coordinates function from the YelpDataProvider protocol
    func searchBusinesses(_ coordinates: Coordinates) async throws -> BusinessSearchResponse {
        let urlString = baseURL + "businesses/search"
        guard var url = URL(string: urlString) else { throw URLError(.badURL) }
        // Building query items
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "latitude", value: "\(coordinates.latitude)"),
            URLQueryItem(name: "longitude", value: "\(coordinates.longitude)"),
            URLQueryItem(name: "limit", value: "50")
        ]
        url.append(queryItems: queryItems)
        // Prepare request with standard parameters
        let request = prepareRequest(url)
        // Make the request
        return try await requestObject(of: BusinessSearchResponse.self, for: request)
    }
    // Implementing the required searchBusiness by locationName function from the YelpDataProvider protocol
    func searchBusinesses(_ locationName: String) async throws -> BusinessSearchResponse {
        let urlString = baseURL + "businesses/search"
        guard var url = URL(string: urlString) else { throw URLError(.badURL) }
        // Building query items
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "location", value: locationName),
            URLQueryItem(name: "limit", value: "50")
        ]
        url.append(queryItems: queryItems)
        // Prepare request with standard parameters
        let request = prepareRequest(url)
        // Make the request
        return try await requestObject(of: BusinessSearchResponse.self, for: request)
    }
    
    // Reusable request function making use of using generics
    private func requestObject<T: Decodable>(of type: T.Type, for request: URLRequest) async throws -> T {
        // Make URLSession request for data
        let (data, response) = try await URLSession.shared.data(for: request)
        // Check for error status codes
        if let response = response as? HTTPURLResponse, response.statusCode != 200 {
            throw ServerError(response.statusCode)
        } else {
            // Attempt to parse and return object of type T.Type from data
            return try decoder.decode(type.self, from: data)
        }
    }
    
    // Function for preparing URLRequests with standardized parameters
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

// Enum of error status codes mapped to those provided by Yelp
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



