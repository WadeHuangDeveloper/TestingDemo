//
//  ValidationServiceTests.swift
//  TestingDemoTests
//
//  Created by Huei-Der Huang on 2025/4/14.
//

import XCTest
@testable import TestingDemo

final class ValidationServiceTests: XCTestCase {
    var validationService: ValidationService!

    override func setUpWithError() throws {
        validationService = ValidationService()
    }
    
    override func tearDownWithError() throws {
        validationService = nil
    }
}

extension ValidationServiceTests {
    
    // MARK: - Username
    
    func test_username_is_valid() throws {
        let username = "1234"
        XCTAssertNoThrow(try validationService.validateUsername(username))
    }
    
    func test_username_is_nil() throws {
        let username: String? = nil
        let expectedError = ValidationError.invalidValue
        XCTAssertThrowsError(try validationService.validateUsername(username)) { error in
            XCTAssertEqual(error as? ValidationError, expectedError)
        }
    }
    
    func test_username_is_too_short() throws {
        let username = "123"
        let expectedError = ValidationError.usernameTooShort
        XCTAssertThrowsError(try validationService.validateUsername(username)) { error in
            let thrownError = error as? ValidationError
            XCTAssertEqual(thrownError, expectedError)
            XCTAssertEqual(thrownError?.errorDescription, expectedError.errorDescription)
        }
    }
    
    func test_username_is_too_long() throws {
        let username = "12345678901"
        let expectedError = ValidationError.usernameTooLong
        XCTAssertThrowsError(try validationService.validateUsername(username)) { error in
            let thrownError = error as? ValidationError
            XCTAssertEqual(thrownError, expectedError)
            XCTAssertEqual(thrownError?.errorDescription, expectedError.errorDescription)
        }
    }
}

extension ValidationServiceTests {
    
    // MARK: - Password
    
    func test_password_is_valid() throws {
        let password = "1234"
        XCTAssertNoThrow(try validationService.validatePassword(password))
    }
    
    func test_password_is_nil() throws {
        let password: String? = nil
        let expectedError = ValidationError.invalidValue
        XCTAssertThrowsError(try validationService.validatePassword(password)) { error in
            let thrownError = error as? ValidationError
            XCTAssertEqual(thrownError, expectedError)
            XCTAssertEqual(thrownError?.errorDescription, expectedError.errorDescription)
        }
    }
    
    func test_password_is_too_short() throws {
        let password = "123"
        let expectedError = ValidationError.passwordTooShort
        XCTAssertThrowsError(try validationService.validatePassword(password)) { error in
            let thrownError = error as? ValidationError
            XCTAssertEqual(thrownError, expectedError)
            XCTAssertEqual(thrownError?.errorDescription, expectedError.errorDescription)
        }
    }
    
    func test_password_is_too_long() throws {
        let password = "12345678901"
        let expectedError = ValidationError.passwordTooLong
        XCTAssertThrowsError(try validationService.validatePassword(password)) { error in
            let thrownError = error as? ValidationError
            XCTAssertEqual(thrownError, expectedError)
            XCTAssertEqual(thrownError?.errorDescription, expectedError.errorDescription)
        }
    }
}

