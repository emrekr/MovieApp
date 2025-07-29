//
//  MovieListPresenter.swift
//  MovieApp
//
//  Created by Emre Kuru on 28.07.2025.
//

import Foundation
import Combine

protocol MovieListPresenterProtocol: AnyObject {
    func didFetchedMovies(_ movies: [Movie], reset: Bool)
    func didFailFetchingMovies(_ error: Error)
}

final class MovieListPresenter: ObservableObject, MovieListPresenterProtocol {
    @Published var movies: [Movie] = []
    @Published var errorMessage: String?
    
    private var interactor: MovieListInteractorProtocol
    
    init(interactor: MovieListInteractorProtocol) {
        self.interactor = interactor
    }
    
    func onAppear() {
        interactor.fetchPopularMovies(reset: false)
    }
    
    func didFetchedMovies(_ movies: [Movie], reset: Bool) {
        DispatchQueue.main.async {
            if reset {
                self.movies = movies
            } else {
                self.movies.append(contentsOf: movies)
            }
        }
    }
    
    func didFailFetchingMovies(_ error: any Error) {
        DispatchQueue.main.async {
            self.errorMessage = error.localizedDescription
        }
    }
    
    func loadMoreMovies() {
        interactor.fetchPopularMovies(reset: false)
    }
}
