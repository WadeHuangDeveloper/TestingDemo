//
//  ValidationService.swift
//  TestingDemo
//
//  Created by Huei-Der Huang on 2025/4/14.
//

import Foundation

enum ValidationError: LocalizedError {
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

class ValidationService {
    private let minLength = 4
    private let maxLength = 11
    
    func validateUsername(_ username: String?) throws -> String {
        guard let username = username, !username.isEmpty else { throw ValidationError.invalidValue }
        guard username.count >= minLength else { throw ValidationError.usernameTooShort }
        guard username.count < maxLength else { throw ValidationError.usernameTooLong }
        return username
    }
    
    func validatePassword(_ password: String?) throws -> String {
        guard let password = password, !password.isEmpty else { throw ValidationError.invalidValue }
        guard password.count >= minLength else { throw ValidationError.passwordTooShort }
        guard password.count < maxLength else { throw ValidationError.passwordTooLong }
        return password
    }
}

