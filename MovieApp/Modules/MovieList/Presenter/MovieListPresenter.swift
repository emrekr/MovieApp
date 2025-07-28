//
//  MovieListPresenter.swift
//  MovieApp
//
//  Created by Emre Kuru on 28.07.2025.
//

import Foundation
import Combine

protocol MovieListPresenterProtocol: AnyObject {
    func didFetchedMovies(_ movies: [Movie])
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
        interactor.fetchPopularMovies()
    }
    
    func didFetchedMovies(_ movies: [Movie]) {
        DispatchQueue.main.async {
            self.movies = movies
        }
    }
    
    func didFailFetchingMovies(_ error: any Error) {
        DispatchQueue.main.async {
            self.errorMessage = error.localizedDescription
        }
    }
}
