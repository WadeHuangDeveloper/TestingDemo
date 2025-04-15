//
//  TestValidationError.swift
//  TestingDemoUITests
//
//  Created by Huei-Der Huang on 2025/4/15.
//

import Foundation

enum TestValidationError: LocalizedError {
    case invalidValue
    case usernameTooShort
    case usernameTooLong
    case passwordTooShort
    case passwordTooLong
    
    var errorDescription: String {
        switch self {
        case .invalidValue:
            return "Invalid value"
        case .usernameTooShort:
            return "Username is too short"
        case .usernameTooLong:
            return "Username is too long"
        case .passwordTooShort:
            return "Password is too short"
        case .passwordTooLong:
            return "Password is too long"
        }
    }
}
