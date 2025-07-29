//
//  MovieListInteractor.swift
//  MovieApp
//
//  Created by Emre Kuru on 28.07.2025.
//

import Foundation

protocol MovieListInteractorProtocol {
    func fetchPopularMovies(reset: Bool)
}

final class MovieListInteractor: MovieListInteractorProtocol {
    private let networkService: NetworkServiceProtocol
    private weak var presenter: MovieListPresenterProtocol?
    
    private var currentPage = 1
    private var totalPages = 1
    private var isLoading = false
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func setPresenter(_ presenter: MovieListPresenterProtocol?) {
        self.presenter = presenter
    }
    
    func fetchPopularMovies(reset: Bool = false) {
        guard !isLoading else { return }
        
        if reset {
            currentPage = 1
            totalPages = 1
        }
        
        guard currentPage <= totalPages else { return }
        
        isLoading = true
        
        Task {
            do {
                let response = try await networkService.request(endpoint: .popularMovies(page: currentPage), responseType: MovieListResponse.self)
                
                totalPages = response.totalPages
                currentPage += 1
                
                presenter?.didFetchedMovies(response.results, reset: reset)
            } catch {
                presenter?.didFailFetchingMovies(error)
            }
            isLoading = false
        }
    }
}
