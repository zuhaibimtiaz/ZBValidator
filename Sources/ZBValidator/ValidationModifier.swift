//
//  ValidationModifier.swift
//  ZBValidator
//
//  Created by Zuhaib Imtiaz on 6/30/25.
//

import SwiftUI

struct ValidationModifier: ViewModifier {
    let errorMessage: String?
    let errorColor: Color = .red
    
    @ViewBuilder
    var errorView: some View {
        if let errorMessage {
            Text(errorMessage)
                .font(.caption) // Smaller text for error message
                .foregroundColor(errorColor)
                .opacity(errorMessage.isEmpty ? 0 : 1) // Hide when no error
                .animation(.easeInOut(duration: 0.2), value: errorMessage) // Smooth transition

        }
    }
    
    func body(content: Content) -> some View {
        VStack(alignment: .leading,
               spacing: 2) {
            content
            
            errorView
        }
    }
}

extension View {
    func withValidation(_ errorMessage: String?) -> some View {
        self.modifier(ValidationModifier(errorMessage: errorMessage))
    }
}
