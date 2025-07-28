//
//  MovieListPresenterTests.swift
//  MovieApp
//
//  Created by Emre Kuru on 28.07.2025.
//

import XCTest
@testable import MovieApp

final class MovieListPresenterTests: XCTestCase {
    final class MockInteractor: MovieListInteractorProtocol {
        var didFetchCalled = false

        func fetchPopularMovies() {
            didFetchCalled = true
        }
    }
    
    func test_onAppear_fetchMovies() {
        let mockInteractor = MockInteractor()
        let presenter = MovieListPresenter(interactor: mockInteractor)
        
        presenter.onAppear()
        
        XCTAssert(mockInteractor.didFetchCalled)
    }
    
    func test_didFetchMovies_updatesMovieList() {
        let mockInteractor = MockInteractor()
        let presenter = MovieListPresenter(interactor: mockInteractor)
        let movies = [Movie(id: 1, title: "Test", overview: "Overview", posterPath: nil, releaseDate: "2024-01-01")]
        
        presenter.didFetchedMovies(movies)
        
        let expectation = XCTestExpectation(description: "Movie list is updated")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(presenter.movies.count, 1)
            XCTAssertEqual(presenter.movies.first?.title, "Test")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_didFailFetchingMoview_setsErrorMessage() {
        let mockInteractor = MockInteractor()
        let presenter = MovieListPresenter(interactor: mockInteractor)
        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Something went wrong"])
        
        presenter.didFailFetchingMovies(error)
        
        let expectation = XCTestExpectation(description: "Error message is set")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(presenter.errorMessage, "Something went wrong")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }
    
}
