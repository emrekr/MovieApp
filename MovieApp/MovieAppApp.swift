//
//  MovieAppApp.swift
//  MovieApp
//
//  Created by Emre Kuru on 28.07.2025.
//

import SwiftUI

@main
struct MovieAppApp: App {
    var body: some Scene {
        WindowGroup {
            Text("Loading...")
                .task {
                    let service = NetworkService()
                    do {
                        let movies = try await service.request(endpoint: .popularMovies(page: 1), responseType: MovieListResponse.self)
                        print("Fetched \(movies.results.count) movies")
                    } catch {
                        print("Error: \(error)")
                    }
                }
        }
    }
}
