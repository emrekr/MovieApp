//
//  MoviePosterView.swift
//  MovieApp
//
//  Created by Emre Kuru on 28.07.2025.
//

import SwiftUI

struct MoviePosterView: View {
    let url: URL?
    let width: CGFloat = 80
    let height: CGFloat = 120
    
    var body: some View {
        Group {
            if let url = url {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure:
                        placeholderImage
                    @unknown default:
                        placeholderImage
                    }
                }
            } else {
                placeholderImage
            }
        }
        .frame(width: width, height: height)
        .clipped()
        .cornerRadius(8)
    }
    
    private var placeholderImage: some View {
        Color.gray.opacity(0.3)
            .overlay(
                Image(systemName: "film")
                    .resizable()
                    .scaledToFit()
                    .padding(20)
                    .foregroundColor(.gray)
            )
    }
}
