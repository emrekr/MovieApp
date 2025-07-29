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
    
    final class MockNetworkService: NetworkServiceProtocol {
        var capturedPage: Int?
        var totalPagesToReturn: Int = 3
        var moviesToReturn: [Movie] = [
            Movie(id: 1, title: "Test", overview: "Overview", posterPath: nil, releaseDate: "2023-01-01")
        ]
        
        func request<T>(endpoint: APIEndpoint, responseType: T.Type) async throws -> T where T : Decodable {
            if case let .popularMovies(page) = endpoint {
                capturedPage = page
            }
            let response = MovieListResponse(
                page: capturedPage ?? 1,
                results: moviesToReturn,
                totalPages: totalPagesToReturn
            )
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
        var receivedResetValue: Bool?
        
        func didFetchedMovies(_ movies: [MovieApp.Movie], reset: Bool) {
            didFetchCalled = true
            receivedResetValue = reset
        }
        
        func didFailFetchingMovies(_ error: Error) {
            didFailCalled = true
        }
    }
    
    // MARK: - Tests
    
    func test_fetchPopularMovies_success_callsDidFetchMovies() async {
        let mockService = MockNetworkService()
        let presenter = MockPresenter()
        let interactor = MovieListInteractor(networkService: mockService)
        interactor.setPresenter(presenter)
        
        interactor.fetchPopularMovies()
        try? await Task.sleep(nanoseconds: 200_000_000)
        
        XCTAssertTrue(presenter.didFetchCalled)
        XCTAssertEqual(mockService.capturedPage, 1)
    }
    
    func test_fetchPopularMovies_withReset_startsFromPage1() async {
        let mockService = MockNetworkService()
        mockService.capturedPage = 5 // should reset
        let presenter = MockPresenter()
        let interactor = MovieListInteractor(networkService: mockService)
        interactor.setPresenter(presenter)
        
        interactor.fetchPopularMovies(reset: true)
        try? await Task.sleep(nanoseconds: 200_000_000)
        
        XCTAssertTrue(presenter.didFetchCalled)
        XCTAssertEqual(mockService.capturedPage, 1)
        XCTAssertTrue(presenter.receivedResetValue ?? false)
    }
    
    func test_fetchPopularMovies_incrementsPage() async {
        let mockService = MockNetworkService()
        let presenter = MockPresenter()
        let interactor = MovieListInteractor(networkService: mockService)
        interactor.setPresenter(presenter)
        
        interactor.fetchPopularMovies()
        try? await Task.sleep(nanoseconds: 200_000_000)
        
        interactor.fetchPopularMovies()
        try? await Task.sleep(nanoseconds: 200_000_000)
        
        XCTAssertEqual(mockService.capturedPage, 2)
    }
    
    func test_fetchPopularMovies_doesNotFetchWhenBeyondTotalPages() async {
        let mockService = MockNetworkService()
        mockService.totalPagesToReturn = 1
        let presenter = MockPresenter()
        let interactor = MovieListInteractor(networkService: mockService)
        interactor.setPresenter(presenter)
        
        interactor.fetchPopularMovies()
        try? await Task.sleep(nanoseconds: 200_000_000)
        
        presenter.didFetchCalled = false
        interactor.fetchPopularMovies() // currentPage now > totalPages
        try? await Task.sleep(nanoseconds: 200_000_000)
        
        XCTAssertFalse(presenter.didFetchCalled, "Should not fetch beyond totalPages")
    }
    
    func test_fetchPopularMovies_doesNotFetchWhenAlreadyLoading() async {
        let mockService = MockNetworkService()
        let presenter = MockPresenter()
        let interactor = MovieListInteractor(networkService: mockService)
        interactor.setPresenter(presenter)
        
        // Simulate ongoing load
        interactor.isLoading = true
        
        interactor.fetchPopularMovies()
        try? await Task.sleep(nanoseconds: 200_000_000)
        
        XCTAssertFalse(presenter.didFetchCalled, "Should not fetch when already loading")
    }
    
    func test_fetchPopularMovies_failure_callsDidFailFetchingMovies() async {
        let mockService = MockNetworkServiceFailure()
        let presenter = MockPresenter()
        let interactor = MovieListInteractor(networkService: mockService)
        interactor.setPresenter(presenter)

        interactor.fetchPopularMovies()
        try? await Task.sleep(nanoseconds: 200_000_000)

        XCTAssertTrue(presenter.didFailCalled, "Should call didFailFetchingMovies on error")
    }
}

