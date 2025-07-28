//
//  SecretsManager.swift
//  MovieApp
//
//  Created by Emre Kuru on 28.07.2025.
//

import Foundation

final class SecretsManager {
    static let shared = SecretsManager()
    
    private var secrets: [String: Any] = [:]
    
    private init() {
        if let url = Bundle.main.url(forResource: "Secrets", withExtension: "plist"),
           let data = try? Data(contentsOf: url),
           let result = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [String: Any] {
            secrets = result
        }
    }
    
    var tmdbToken: String {
        secrets["TMDBAccessToken"] as? String ?? ""
    }
    
    var tmdbBaseURL: String {
        secrets["TMDBBaseURL"] as? String ?? ""
    }
}
