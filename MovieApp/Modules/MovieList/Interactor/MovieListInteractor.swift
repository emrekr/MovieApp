//
//  MovieListInteractor.swift
//  MovieApp
//
//  Created by Emre Kuru on 28.07.2025.
//

import Foundation

protocol MovieListInteractorProtocol {
    func fetchPopularMovies()
}

final class MovieListInteractor: MovieListInteractorProtocol {
    private let networkService: NetworkServiceProtocol
    private weak var presenter: MovieListPresenterProtocol?
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func setPresenter(_ presenter: MovieListPresenterProtocol?) {
        self.presenter = presenter
    }
    
    func fetchPopularMovies() {
        Task {
            do {
                let response = try await networkService.request(endpoint: .popularMovies(page: 1), responseType: MovieListResponse.self)
                presenter?.didFetchedMovies(response.results)
            } catch {
                presenter?.didFailFetchingMovies(error)
            }
        }
    }
}
