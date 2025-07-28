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
                }
                .navigationTitle("Popular Movies")
            }
        }
        .onAppear {
            presenter.onAppear()
        }
    }
}
