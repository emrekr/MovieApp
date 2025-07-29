//
//  MovieAppUITests.swift
//  MovieAppUITests
//
//  Created by Emre Kuru on 28.07.2025.
//

import XCTest

final class MovieAppUITests: XCTestCase {
    
    func test_movieListAppearsOnLaunch() {
        let app = XCUIApplication()
        app.launch()

        let movieList = app.collectionViews[AccessibilityIdentifiers.MovieList.list]
        let exists = movieList.waitForExistence(timeout: 5)

        XCTAssertTrue(exists, "Movie list should be visible on launch")
    }
    
    func test_movieRowContainsTitleOverviewAndPoster() {
        let app = XCUIApplication()
        app.launch()

        let firstRow = app.collectionViews.otherElements[AccessibilityIdentifiers.MovieList.row].firstMatch
        XCTAssertTrue(firstRow.waitForExistence(timeout: 5), "First movie row should exist")

        let title = firstRow.staticTexts[AccessibilityIdentifiers.MovieList.title]
        XCTAssertTrue(title.exists, "Movie title should be visible")

        let overview = firstRow.staticTexts[AccessibilityIdentifiers.MovieList.overview]
        XCTAssertTrue(overview.exists, "Movie overview should be visible")

        let poster = firstRow.images[AccessibilityIdentifiers.MovieList.poster]
        XCTAssertTrue(poster.exists, "Movie poster should be visible")
    }
    
    func test_scrollLoadsMoreMovies() {
        let app = XCUIApplication()
        app.launch()

        let movieList = app.collectionViews[AccessibilityIdentifiers.MovieList.list]
        XCTAssertTrue(movieList.waitForExistence(timeout: 5), "Movie list should exist")

        let firstMovieTitle = movieList.staticTexts[AccessibilityIdentifiers.MovieList.title].firstMatch.label

        movieList.swipeUp()
        movieList.swipeUp()

        let newMovieTitle = movieList.staticTexts[AccessibilityIdentifiers.MovieList.title].firstMatch.label
        XCTAssertNotEqual(firstMovieTitle, newMovieTitle, "After scroll, a different movie should appear at the top")
    }
}
