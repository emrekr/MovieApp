//
//  MovieDetailResponse.swift
//  MovieApp
//
//  Created by Emre Kuru on 4.08.2025.
//

import Foundation

struct MovieDetailResponse: Decodable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let releaseDate: String
    let runtime: Int?
    let voteAverage: Double?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case runtime
        case voteAverage = "vote_average"
    }
    
    var posterURL: URL? {
        ImageConfigurationManager.shared.makePosterURL(path: posterPath)
    }
}
