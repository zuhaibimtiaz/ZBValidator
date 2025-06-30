# ZBValidator

# 🛡️ ZBValidator Property Wrapper for Swift

![Swift](https://img.shields.io/badge/Swift-6.0-orange)
![Platform](https://img.shields.io/badge/Platform-iOS)
![License](https://img.shields.io/badge/License-MIT-green)

A lightweight and reusable `@ZBValidator` property wrapper for validating values in Swift. It supports multiple common validation rules and returns the first matching error if validation fails.

---

## ✨ Features

- ✅ Validate values using a chain of rules
- 🔍 Built-in rules: `required`, `regularExpression`, `minLength`, `range`
- 🔁 Tracks value changes and only validates when changed
- 🧪 Designed for clean and readable form validation logic

---

## 📦 Installation

### Swift Package Manager
Add `ZBValidator` to your project via Swift Package Manager:

1. In Xcode, go to `File > Add Packages`.
2. Enter `https://github.com/zuhaibimtiaz/ZBValidator.git`


---

## 🚀 Usage

### Basic Example

```swift
@ZBValidator(.required(errorMessage: "Name is required"),
           .minLength(3, errorMessage: "Name must be at least 3 characters"))
var name: String = ""
```

 #### Check for validation errors using the projected value

  ```swift
if let errorMessage = $name {
    print(errorMessage) // e.g., "Name is required"
}
```
###  Full Example

  ```swift
import SwiftUI

struct ContentView: View {
    @ZBValidator(.required(errorMessage: "Email is required"),
               .regularExpression(pattern: #"^\S+@\S+\.\S+$"#, errorMessage: "Invalid email format"))
    private var email: String = ""
    
    @ZBValidator(.range(18, 99, errorMessage: "Age must be between 18 and 99"))
    private var age: Int = 0

    var body: some View {
        Form {
            Section(header: Text("User Info")) {
                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                if let error = $email {
                    Text(error).foregroundColor(.red)
                }

                TextField("Age", value: $age, formatter: NumberFormatter())
                    .keyboardType(.numberPad)
                if let error = $age {
                    Text(error).foregroundColor(.red)
                }
            }
        }
    }
}
```
## 🔍 Supported Validation Rules

| Rule                                                                 | Description                                       |
|----------------------------------------------------------------------|---------------------------------------------------|
| `.required(errorMessage: String)`                                    | Ensures string is not empty or whitespace.        |
| `.regularExpression(pattern: String, errorMessage: String)`         | Validates string using a regular expression.      |
| `.minLength(Int, errorMessage: String)`                              | Validates minimum length of a string.             |
| `.range(Int, Int, errorMessage: String)`                             | Ensures integer value falls within a range.       |
