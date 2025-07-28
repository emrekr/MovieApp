//
//  MovieListRouter.swift
//  MovieApp
//
//  Created by Emre Kuru on 28.07.2025.
//

import Foundation
import SwiftUI

final class MovieListRouter {
    static func createModule() -> some View {
        let networkService = NetworkService()
        let interactor = MovieListInteractor(networkService: networkService)
        let presenter = MovieListPresenter(interactor: interactor)
        interactor.setPresenter(presenter)
        return MovieListView(presenter: presenter)
    }
}
