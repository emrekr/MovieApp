//
//  UIView+Extensions.swift
//  MovieApp
//
//  Created by Emre Kuru on 29.07.2025.
//

import SwiftUI

extension View {
    /// Assigns an accessibility identifier and makes child views discoverable in UI tests.
    func testIdentifier(_ id: String) -> some View {
        self
            .accessibilityIdentifier(id)
            .accessibilityElement(children: .contain)
    }
}
