//
//  MockNetworkService.swift
//  MovieApp
//
//  Created by Emre Kuru on 28.07.2025.
//

import Foundation
@testable import MovieApp

final class MockNetworkService: NetworkServiceProtocol {
    var shouldReturnError: Bool = false
    var dummyMoview: [Movie] = []
    
    func request<T>(endpoint: APIEndpoint, responseType: T.Type) async throws -> T where T : Decodable {
        if shouldReturnError {
            throw URLError(.notConnectedToInternet)
        }
        
        let response = MovieListResponse(page: 1, results: dummyMoview, totalPages: 1)
        
        return response as! T
    }
}
