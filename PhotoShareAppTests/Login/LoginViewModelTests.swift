//
//  PhotoShareAppTests.swift
//  PhotoShareAppTests
//
//  Created by Berkay Sancar on 29.11.2022.
//

import XCTest
@testable import PhotoShareApp

final class LoginViewModelTests: XCTestCase {
    
    private var viewModel: LoginViewModel!
    private var view: MockLoginViewController!
    private var authManager: MockAuthManager!

    override func setUp() {
        super.setUp()
        
        view = .init()
        authManager = .init()
        viewModel = .init(view: view, authManager: authManager)
    }
    
    override func tearDown() {
        super.tearDown()
        
        view = nil
        authManager = nil
        viewModel = nil
    }
    
    func test_viewDidLoad_InvokesPrepareSignWithAppleMethod() {
        // GIVEN
        XCTAssertFalse(view.invokedPrepareSignInWithApple)
        // WHEN
        viewModel.viewDidLoad()
        // THEN
        XCTAssertEqual(view.invokedPrepareSignInWithAppleCount, 1)
    }
    
    func test_didTapSignInWithApple_InvokesPerformSignInWithAppleMethod() {
        XCTAssertFalse(view.invokedPerformSignInWithApple)
        
        viewModel.didTapSignInWithApple()
        
        XCTAssertEqual(view.invokedPerformSignInWithAppleCount, 1)
    }
    
    func test_didTapLogin_PerformSegue() {
        
        XCTAssertFalse(authManager.invokedLogin)
        XCTAssertFalse(view.invokedPerformSegue)
        XCTAssertNil(view.invokedPerformSegueIdentifier)
        
        viewModel.didTapLogin(email: "test@mail.com", password: "123456")
        
        XCTAssertEqual(authManager.invokedLoginCount, 1)
        XCTAssertEqual(view.invokedPerformSegueIdentifier, SegueID.feed.rawValue)
        XCTAssertEqual(view.invokedPerformSegueCount, 1)
    }
    
    func test_didTapSignIn_PerformSegue() {
        
        XCTAssertFalse(authManager.invokedSignUp)
        XCTAssertFalse(view.invokedPerformSegue)
        XCTAssertNil(view.invokedPerformSegueIdentifier)
        
        viewModel.didTapSignIn(email: "test@mail.com", password: "123456")
        
        XCTAssertEqual(authManager.invokedSignUpCount, 1)
        XCTAssertEqual(view.invokedPerformSegueIdentifier, SegueID.feed.rawValue)
        XCTAssertEqual(view.invokedPerformSegueCount, 1)
    }
}
