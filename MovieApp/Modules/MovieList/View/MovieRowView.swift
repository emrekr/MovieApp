//
//  MovieRowView.swift
//  MovieApp
//
//  Created by Emre Kuru on 28.07.2025.
//

import SwiftUI

struct MovieRowView: View {
    let movie: Movie
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            MoviePosterView(url: movie.posterURL)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(movie.title)
                    .font(.headline)
                Text(movie.overview)
                    .font(.subheadline)
                    .lineLimit(3)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 6)
    }
}
