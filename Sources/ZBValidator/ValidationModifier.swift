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
    
    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            content
            Text(errorMessage ?? "")
                .font(.caption) // Smaller text for error message
                .foregroundColor(errorColor)
                .frame(height: 20) // Keep consistent height
                .opacity(errorMessage == nil ? 0 : 1) // Hide when no error
                .animation(.easeInOut(duration: 0.2), value: errorMessage) // Smooth transition
        }
    }
}

extension View {
    func withValidation(_ errorMessage: String?) -> some View {
        self.modifier(ValidationModifier(errorMessage: errorMessage))
    }
}
