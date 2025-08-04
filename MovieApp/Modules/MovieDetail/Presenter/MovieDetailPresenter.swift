//
//  MovieDetailPresenter.swift
//  MovieApp
//
//  Created by Emre Kuru on 4.08.2025.
//

import Combine
import Foundation

protocol MovieDetailPresenterProtocol: AnyObject {
    func didFetchMovieDetail(movie: MovieDetailResponse)
    func didFailToFetchMovieDetail(error: Error)
}

final class MovieDetailPresenter: MovieDetailPresenterProtocol, ObservableObject {
    @Published var detail: MovieDetailResponse?
    @Published var errorMessage: String?
    
    private let interactor: MovieDetailInteractorProtocol
    
    init(interactor: MovieDetailInteractorProtocol) {
        self.interactor = interactor
    }
    
    func onAppear() {
        interactor.fetchMovieDetail()
    }
    
    func didFetchMovieDetail(movie: MovieDetailResponse) {
        DispatchQueue.main.async {
            self.detail = movie
        }
    }
    func didFailToFetchMovieDetail(error: Error) {
        DispatchQueue.main.async {
            self.errorMessage = error.localizedDescription
        }
    }
}
