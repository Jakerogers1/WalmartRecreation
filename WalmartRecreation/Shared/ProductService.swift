//
//  ProductService.swift
//  WalmartRecreation
//
//  Created by jmanerr on 1/30/24.
//

import Foundation

struct ProductService {
    private static let apiKey = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTUsInVzZXJuYW1lIjoia21pbmNoZWxsZSIsImVtYWlsIjoia21pbmNoZWxsZUBxcS5jb20iLCJmaXJzdE5hbWUiOiJKZWFubmUiLCJsYXN0TmFtZSI6IkhhbHZvcnNvbiIsImdlbmRlciI6ImZlbWFsZSIsImltYWdlIjoiaHR0cHM6Ly9yb2JvaGFzaC5vcmcvYXV0cXVpYXV0LnBuZz9zaXplPTUweDUwJnNldD1zZXQxIiwiaWF0IjoxNjM1NzczOTYyLCJleHAiOjE2MzU3Nzc1NjJ9.n9PQX8w8ocKo0dMCw3g8bKhjB8Wo7f7IONFBDqfxKhs"
    private static let session = URLSession.shared
    private static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        return decoder
    }
    
    ///   - title: Search term,
    /// - Returns: An array of products matching the specified parameters.
    public static func findProducts(
        title: String
        
    ) async throws -> [Product] {
        // TODO: Construct the url with URLComponents with these query params
        var components = URLComponents(string: "https://dummyjson.com/products/search")
        components?.queryItems = [URLQueryItem(name: "q", value: title)
        ]
        
        // TODO: Construct the URLRequest
        //   - http method: "GET"
        //   - "Authorization" header: apiKey
        //   - "accept" header: "application/json"
        guard let url = components?.url else { fatalError("Invalid URL") }
        let headers = [
            "accept": "application/json",
            "Authorization": apiKey
        ]
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        // TODO: Make the request with URLSession
        //   - be sure to use the `data(for: request)` method
        let (data, _) = try await session.data(for: request)
        //        print("\(data)")
        printData(data: data)
        //        print("\(url)")
        
        
        // TODO: Decode the response using the decoder instantiated above
        let response = try decoder.decode(DummyJSONResponse.self, from: data)
        
        return response.products
        
    }
    
    /// Helper method to print the JSON data without decoding
    /// Very helpful when debugging
    private static func printData(data: Data) {
        guard let string = String(data: data, encoding: .utf8) else {
            print("Unable to convert data to string.")
            return
        }
        print("Received Data:")
        print(string)
    }
}

