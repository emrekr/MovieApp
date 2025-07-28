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
            List(presenter.movies) { movie in
                VStack(alignment: .leading, spacing: 6) {
                    Text(movie.title)
                        .font(.headline)
                    Text(movie.overview)
                        .font(.subheadline)
                        .lineLimit(3)
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("Popular Movies")
        }
        .onAppear {
            presenter.onAppear()
        }
        .alert(item: $presenter.errorMessage) { msg in
            Alert(title: Text("Error"), message: Text(msg), dismissButton: .default(Text("OK")))
        }
    }
}

extension String: @retroactive Identifiable {
    public var id: String { self }
}
