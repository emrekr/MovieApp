//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by Emre Kuru on 4.08.2025.
//

import SwiftUI

struct MovieDetailView: View {
    @StateObject var presenter: MovieDetailPresenter
    
    var body: some View {
        ScrollView {
            if let detail = presenter.detail {
                VStack(alignment: .leading, spacing: 16) {
                    AsyncImage(url: detail.posterURL) { image in
                        image.resizable().scaledToFit()
                    } placeholder: {
                        Color.gray
                    }
                    Text(detail.title)
                        .font(.title)
                        .bold()
                    Text("Release Date: \(detail.releaseDate)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    if let runtime = detail.runtime {
                        Text("Runtime: \(runtime) minutes")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    if let rating = detail.voteAverage {
                        Text("Rating: \(rating, specifier: "%.1f")/10")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Text(detail.overview)
                        .font(.body)
                        .padding(.top)
                }
                .padding()
            } else if let errorMessage = presenter.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            } else {
                ProgressView("Loading...")
                    .padding()
            }
        }
        .onAppear {
            presenter.onAppear()
        }
        .navigationTitle("Movie Detail")
    }
}
