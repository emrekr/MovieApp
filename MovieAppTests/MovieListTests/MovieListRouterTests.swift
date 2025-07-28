//
//  MovieListRouterTests.swift
//  MovieApp
//
//  Created by Emre Kuru on 28.07.2025.
//

import XCTest
import SwiftUI
@testable import MovieApp

final class MovieListRouterTests: XCTestCase {

    func test_createModule_returnsView() {
        let view = MovieListRouter.createModule()
        let _ = AnyView(view)
    }
}
