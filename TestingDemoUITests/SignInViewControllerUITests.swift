//
//  SignInViewControllerUITests.swift
//  TestingDemoUITests
//
//  Created by Huei-Der Huang on 2025/4/14.
//

import XCTest
@testable import TestingDemo

final class SignInViewControllerUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    private func assertAlert(message: String) {
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.waitForExistence(timeout: 2.0))
        XCTAssertTrue(alert.staticTexts[message].exists)
    }
}

extension SignInViewControllerUITests {
    
    // MARK: - Username
    
    func test_sign_in_button_with_valid_username_and_password() throws {
        let username = "1234"
        let password = "1234"
        
        let usernameTextField = app.textFields["usernameTextField"]
        let passwordTextField = app.secureTextFields["passwordTextField"]
        let signInButton = app.buttons["signInButton"]
        
        usernameTextField.tap()
        usernameTextField.typeText(username)
        
        passwordTextField.tap()
        passwordTextField.typeText(password)
        
        signInButton.tap()
        
        assertAlert(message: TestUITextResource.successAlert)
    }
    
    func test_sign_in_button_with_empty_username() throws {
        let password = "1234"
        
        let passwordTextField = app.secureTextFields["passwordTextField"]
        let signInButton = app.buttons["signInButton"]
        
        passwordTextField.tap()
        passwordTextField.typeText(password)
        
        signInButton.tap()
        
        assertAlert(message: TestValidationError.invalidValue.errorDescription)
    }
    
    func test_sign_in_button_with_long_username() throws {
        let username = "12345678901"
        let password = "1234"
        
        let usernameTextField = app.textFields["usernameTextField"]
        let passwordTextField = app.secureTextFields["passwordTextField"]
        let signInButton = app.buttons["signInButton"]
        
        usernameTextField.tap()
        usernameTextField.typeText(username)
        
        passwordTextField.tap()
        passwordTextField.typeText(password)
        
        signInButton.tap()
        
        assertAlert(message: TestValidationError.usernameTooLong.errorDescription)
    }
    
    func test_sign_in_button_with_short_username() throws {
        let username = "12"
        let password = "1234"
        
        let usernameTextField = app.textFields["usernameTextField"]
        let passwordTextField = app.secureTextFields["passwordTextField"]
        let signInButton = app.buttons["signInButton"]
        
        usernameTextField.tap()
        usernameTextField.typeText(username)
        
        passwordTextField.tap()
        passwordTextField.typeText(password)
        
        signInButton.tap()
        
        assertAlert(message: TestValidationError.usernameTooShort.errorDescription)
    }
    
}

extension SignInViewControllerUITests {
    
    // MARK: - Password
    
    func test_sign_in_button_with_empty_password() throws {
        let username = "1234"
        
        let usernameTextField = app.textFields["usernameTextField"]
        let signInButton = app.buttons["signInButton"]
        
        usernameTextField.tap()
        usernameTextField.typeText(username)
        
        signInButton.tap()
        
        assertAlert(message: TestValidationError.invalidValue.errorDescription)
    }
    
    func test_sign_in_button_with_long_password() throws {
        let username = "1234"
        let password = "12345678901"
        
        let usernameTextField = app.textFields["usernameTextField"]
        let passwordTextField = app.secureTextFields["passwordTextField"]
        let signInButton = app.buttons["signInButton"]
        
        usernameTextField.tap()
        usernameTextField.typeText(username)
        
        passwordTextField.tap()
        passwordTextField.typeText(password)
        
        signInButton.tap()
        
        assertAlert(message: TestValidationError.passwordTooLong.errorDescription)
    }
    
    func test_sign_in_button_with_short_password() throws {
        let username = "1234"
        let password = "12"
        
        let usernameTextField = app.textFields["usernameTextField"]
        let passwordTextField = app.secureTextFields["passwordTextField"]
        let signInButton = app.buttons["signInButton"]
        
        usernameTextField.tap()
        usernameTextField.typeText(username)
        
        passwordTextField.tap()
        passwordTextField.typeText(password)
        
        signInButton.tap()
        
        assertAlert(message: TestValidationError.passwordTooShort.errorDescription)
    }
}
