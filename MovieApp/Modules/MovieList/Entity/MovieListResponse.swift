//
//  MovieListResponse.swift
//  MovieApp
//
//  Created by Emre Kuru on 28.07.2025.
//

import Foundation

struct MovieListResponse: Decodable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
    }
}

struct Movie: Decodable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let releaseDate: String

    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
    
    var posterURL: URL? {
        ImageConfigurationManager.shared.makePosterURL(path: posterPath)
    }
}
