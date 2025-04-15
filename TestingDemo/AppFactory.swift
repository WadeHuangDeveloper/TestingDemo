//
//  AppFactory.swift
//  TestingDemo
//
//  Created by Huei-Der Huang on 2025/4/14.
//

import Foundation

struct AppFactory {
    static func makeRootViewController() -> SignInViewController {
        let validationService = ValidationService()
        let viewModel = SignInViewControllerViewModel(validationService: validationService)
        let viewController = SignInViewController(viewModel: viewModel)
        return viewController
    }
}
