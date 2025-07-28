//
//  NetworkServiceProtocol.swift
//  MovieApp
//
//  Created by Emre Kuru on 28.07.2025.
//

import Foundation

protocol NetworkServiceProtocol {
    func request<T: Decodable>(
        endpoint: APIEndpoint,
        responseType: T.Type
    ) async throws -> T
}
