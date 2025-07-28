//
//  NetworkService.swift
//  MovieApp
//
//  Created by Emre Kuru on 28.07.2025.
//

import Foundation

final class NetworkService: NetworkServiceProtocol {
    
    private let session: URLSession = .shared
    private let baseURL = SecretsManager.shared.tmdbBaseURL
    private let accessToken = SecretsManager.shared.tmdbToken
    
    func request<T>(endpoint: APIEndpoint, responseType: T.Type) async throws -> T where T : Decodable {
        var components = URLComponents(string: baseURL + endpoint.path)!
        components.queryItems = endpoint.queryItems

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
}
