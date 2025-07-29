//
//  MovieListView.swift
//  MovieApp
//
//  Created by Emre Kuru on 28.07.2025.
//

import SwiftUI

struct MovieListView: View {
    @StateObject var presenter: MovieListPresenter
    
    var body: some View {
        NavigationView {
            ErrorAlertWrapper(errorMessage: $presenter.errorMessage) {
                List(presenter.movies) { movie in
                    MovieRowView(movie: movie)
                        .testIdentifier(AccessibilityIdentifiers.MovieList.row)
                        .onAppear {
                            if movie.id == presenter.movies.last?.id {
                                presenter.loadMoreMovies()
                            }
                        }
                }
                .navigationTitle("Popular Movies")
                .testIdentifier(AccessibilityIdentifiers.MovieList.list)
            }
        }
        .navigationViewStyle(.stack)
        .onAppear {
            presenter.onAppear()
        }
    }
}
