//
//  ImageConfigurationManager.swift
//  MovieApp
//
//  Created by Emre Kuru on 28.07.2025.
//

import Foundation

final class ImageConfigurationManager {
    static let shared = ImageConfigurationManager()
    
    private let secureBaseURL = "https://image.tmdb.org/t/p/"
    private let defaultSize = "w500"
    
    private init() {}
    
    func makePosterURL(path: String?, size: String? = nil) -> URL? {
        guard let path = path else { return nil }
        let finalSize = size ?? defaultSize
        return URL(string: "\(secureBaseURL)\(finalSize)\(path)")
    }
}
