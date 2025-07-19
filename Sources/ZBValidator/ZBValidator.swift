// The Swift Programming Language
// https://docs.swift.org/swift-book
//
//  ZBValidator.swift
//  ZBValidator
//
//  Created by Zuhaib Imtiaz on 6/30/25.
//

import Foundation

@propertyWrapper
struct ZBValidator<T: Equatable> {
    
    enum ZBValidationRule {
        case required(errorMessage: String)
        case regularExpression(pattern: String, errorMessage: String)
        case minLength(Int, errorMessage: String)
        case range(Int, Int, errorMessage: String) // For numeric strings
    }
    
    private var value: T
    private var initialValue: T
    private let rules: [ZBValidationRule]
    private var isChanged: Bool = false
    
    var wrappedValue: T {
        get { value }
        set {
            value = newValue
            isChanged = newValue != initialValue
        }
    }
    
    var projectedValue: String? {
        guard isChanged else { return nil }
        for rule in rules {
            if let message = validate(rule: rule) {
                return message
            }
        }
        return nil
    }
    
    init(
        wrappedValue: T,
        _ rules: ZBValidationRule...
    ) {
        self.value = wrappedValue
        self.initialValue = wrappedValue
        self.rules = rules
    }
    
    init(
        wrappedValue: T,
        _ rules: [ZBValidationRule]
    ) {
        self.value = wrappedValue
        self.initialValue = wrappedValue
        self.rules = rules
    }
    
    private func validate(rule: ZBValidationRule) -> String? {
        switch rule {
        case .required(let message):
            if let string = value as? String,
               string.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                return message
            }
            
        case .regularExpression(let pattern, let message):
            return validateRegex(pattern: pattern, message: message)
            
        case .minLength(let length, let message):
            guard let stringValue = value as? String else { return nil }

            if stringValue.count < length {
                return message
            }
            
        case .range(let minimuim, let maximum, let message):
            guard let number = value as? Int else {
                return "Value must be a number"
            }
            if number < minimuim || number > maximum {
                return message
            }
        }
        return nil
    }
    
    private func validateRegex(
        pattern: String,
        message: String
    ) -> String? {
        guard let stringValue = value as? String else { return nil }
        let regex = try? NSRegularExpression(
            pattern: pattern,
            options: .caseInsensitive
        )
        let range = NSRange(
            location: 0,
            length: stringValue.utf16.count
        )
        return regex?.firstMatch(in: stringValue, options: [], range: range) == nil ? message : nil
    }
    
}
