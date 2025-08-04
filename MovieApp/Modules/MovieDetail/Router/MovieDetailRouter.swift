//
//  MovieDetailRouter.swift
//  MovieApp
//
//  Created by Emre Kuru on 4.08.2025.
//

enum MovieDetailRouter {
    static func createModule(movieId: Int) -> MovieDetailView {
        let networkService = NetworkService()
        let interactor = MovieDetailInteractor(movieId: movieId, networkService: networkService)
        let presenter = MovieDetailPresenter(interactor: interactor)
        interactor.setPresenter(presenter)
        return MovieDetailView(presenter: presenter)
    }
}
