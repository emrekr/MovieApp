//
//  ErrorAlertWrapper.swift
//  MovieApp
//
//  Created by Emre Kuru on 28.07.2025.
//

import SwiftUI

struct ErrorAlertWrapper<Content: View>: View {
    @Binding var errorMessage: String?
    let content: Content
    
    init(errorMessage: Binding<String?>, @ViewBuilder content: () -> Content) {
        self._errorMessage = errorMessage
        self.content = content()
    }
    
    var body: some View {
        content
            .alert(item: $errorMessage) { message in
                Alert(
                    title: Text("Error"),
                    message: Text(message),
                    dismissButton: .default(Text("OK"))
                )
            }
    }
    
}

extension String: @retroactive Identifiable {
    public var id: String { self }
}
