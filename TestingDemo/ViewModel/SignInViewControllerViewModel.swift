//
//  SignInViewControllerViewModel.swift
//  TestingDemo
//
//  Created by Huei-Der Huang on 2025/4/14.
//

import Foundation
import Combine

class SignInViewControllerViewModel {
    private let validationService: ValidationService
    let event = PassthroughSubject<AuthenticationEvent, Never>()
    
    init(validationService: ValidationService) {
        self.validationService = validationService
    }
    
    func validateUsername(_ username: String?) throws -> String {
        try validationService.validateUsername(username)
    }
    
    func validatePassword(_ password: String?) throws -> String {
        try validationService.validatePassword(password)
    }
    
    func signIn(username: String, password: String) {
        event.send(.signIn)
    }
}
