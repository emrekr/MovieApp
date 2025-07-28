//
//  MovieListInteractorTests.swift
//  MovieApp
//
//  Created by Emre Kuru on 28.07.2025.
//

import XCTest
@testable import MovieApp

final class MovieListInteractorTests: XCTestCase {
    
    // MARK: - Mocks
    
    final class MockNetworkServiceSuccess: NetworkServiceProtocol {
        func request<T>(endpoint: APIEndpoint, responseType: T.Type) async throws -> T where T : Decodable {
            let movie = Movie(id: 1, title: "Test", overview: "Overview", posterPath: nil, releaseDate: "2023-01-01")
            let response = MovieListResponse(page: 1, results: [movie], totalPages: 1)
            return response as! T
        }
    }

    final class MockNetworkServiceFailure: NetworkServiceProtocol {
        struct DummyError: Error {}
        func request<T>(endpoint: APIEndpoint, responseType: T.Type) async throws -> T where T : Decodable {
            throw DummyError()
        }
    }

    final class MockPresenter: MovieListPresenterProtocol {
        
        var didFetchCalled = false
        var didFailCalled = false
        
        func didFetchedMovies(_ movies: [MovieApp.Movie]) {
            didFetchCalled = true
        }

        func didFailFetchingMovies(_ error: Error) {
            didFailCalled = true
        }
    }
    
    // MARK: - Tests
    
    func test_fetchPopularMovies_success_callsDidFetchMovies() async {
        let mockService = MockNetworkServiceSuccess()
        let presenter = MockPresenter()
        let interactor = MovieListInteractor(networkService: mockService)
        interactor.setPresenter(presenter)
        
        interactor.fetchPopularMovies()
        try? await Task.sleep(nanoseconds: 200_000_000)
        
        XCTAssertTrue(presenter.didFetchCalled)
    }
    
    func test_fetchPopularMovies_failure_callsDidFailFetchingMovies() async {
        let mockService = MockNetworkServiceFailure()
        let presenter = MockPresenter()
        let interactor = MovieListInteractor(networkService: mockService)
        interactor.setPresenter(presenter)
        
        interactor.fetchPopularMovies()
        try? await Task.sleep(nanoseconds: 200_000_000)
    
        XCTAssertTrue(presenter.didFailCalled)
    }
    
}
