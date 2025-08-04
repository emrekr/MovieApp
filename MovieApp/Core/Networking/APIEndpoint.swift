//
//  APIEndpoint.swift
//  MovieApp
//
//  Created by Emre Kuru on 28.07.2025.
//

import Foundation

enum APIEndpoint {
    case popularMovies(page: Int)
    case movieDetail(id: String)
    
    var path: String {
        switch self {
        case .popularMovies:
            return "/3/movie/popular"
        case .movieDetail(let id):
            return "/3/movie/\(id)"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .popularMovies(page: let page):
            return [
                URLQueryItem(name: "page", value: String(page)),
                URLQueryItem(name: "language", value: "en-US")
            ]
        case .movieDetail:
            return [URLQueryItem(name: "language", value: "en-US")]
        }
    }
}
