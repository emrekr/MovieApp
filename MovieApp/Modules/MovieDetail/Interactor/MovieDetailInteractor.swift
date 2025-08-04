//
//  MovieDetailInteractor.swift
//  MovieApp
//
//  Created by Emre Kuru on 4.08.2025.
//

protocol MovieDetailInteractorProtocol {
    func fetchMovieDetail()
}

final class MovieDetailInteractor: MovieDetailInteractorProtocol {
    private let networkService: NetworkServiceProtocol
    private weak var presenter: MovieDetailPresenterProtocol?
    private let movieId: Int
    
    init(movieId: Int, networkService: NetworkServiceProtocol) {
        self.movieId = movieId
        self.networkService = networkService
    }
    
    func setPresenter(_ presenter: MovieDetailPresenterProtocol?) {
        self.presenter = presenter
    }
    
    func fetchMovieDetail() {
        Task {
            do {
                let endpoint = APIEndpoint.movieDetail(id: "\(movieId)")
                let response = try await self.networkService.request(endpoint: endpoint, responseType: MovieDetailResponse.self)
                presenter?.didFetchMovieDetail(movie: response)
            } catch {
                presenter?.didFailToFetchMovieDetail(error: error)
            }
        }
    }
}
