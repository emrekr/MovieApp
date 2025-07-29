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
        var lastResetValue: Bool?

        func fetchPopularMovies(reset: Bool) {
            didFetchCalled = true
            lastResetValue = reset
        }
    }
    
    func test_onAppear_fetchMovies() {
        let mockInteractor = MockInteractor()
        let presenter = MovieListPresenter(interactor: mockInteractor)
        
        presenter.onAppear()
        
        XCTAssert(mockInteractor.didFetchCalled)
        XCTAssertEqual(mockInteractor.lastResetValue, false)
    }
    
    func test_didFetchMovies_updatesMovieList() {
        let mockInteractor = MockInteractor()
        let presenter = MovieListPresenter(interactor: mockInteractor)
        let movies = [Movie(id: 1, title: "Test", overview: "Overview", posterPath: nil, releaseDate: "2024-01-01")]
        
        presenter.didFetchedMovies(movies, reset: false)
        
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
    
    func test_didFetchMovies_appendsMovies_whenResetIsFalse() {
            let mockInteractor = MockInteractor()
            let presenter = MovieListPresenter(interactor: mockInteractor)
            presenter.movies = [Movie(id: 1, title: "Old", overview: "Old Overview", posterPath: nil, releaseDate: "2024-01-01")]
            let newMovies = [Movie(id: 2, title: "New", overview: "Overview", posterPath: nil, releaseDate: "2024-02-01")]
            
            presenter.didFetchedMovies(newMovies, reset: false)
            
            let expectation = XCTestExpectation(description: "Movies are appended")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                XCTAssertEqual(presenter.movies.count, 2)
                XCTAssertEqual(presenter.movies.last?.title, "New")
                expectation.fulfill()
            }
            
            wait(for: [expectation], timeout: 1.0)
        }
        
        func test_didFetchMovies_replacesMovies_whenResetIsTrue() {
            let mockInteractor = MockInteractor()
            let presenter = MovieListPresenter(interactor: mockInteractor)
            presenter.movies = [Movie(id: 1, title: "Old", overview: "Old Overview", posterPath: nil, releaseDate: "2024-01-01")]
            let newMovies = [Movie(id: 2, title: "New", overview: "Overview", posterPath: nil, releaseDate: "2024-02-01")]
            
            presenter.didFetchedMovies(newMovies, reset: true)
            
            let expectation = XCTestExpectation(description: "Movies are replaced")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                XCTAssertEqual(presenter.movies.count, 1)
                XCTAssertEqual(presenter.movies.first?.title, "New")
                expectation.fulfill()
            }
            
            wait(for: [expectation], timeout: 1.0)
        }
        
        func test_didFailFetchingMovies_setsErrorMessage() {
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
        
        func test_loadMoreMovies_callsInteractorWithResetFalse() {
            let mockInteractor = MockInteractor()
            let presenter = MovieListPresenter(interactor: mockInteractor)
            
            presenter.loadMoreMovies()
            
            XCTAssertTrue(mockInteractor.didFetchCalled)
            XCTAssertEqual(mockInteractor.lastResetValue, false)
        }
        
        func test_resetMovies_callsInteractorWithResetTrue() {
            let mockInteractor = MockInteractor()
            let presenter = MovieListPresenter(interactor: mockInteractor)
            
            presenter.resetMovies()
            
            XCTAssertTrue(mockInteractor.didFetchCalled)
            XCTAssertEqual(mockInteractor.lastResetValue, true)
        }
    }
