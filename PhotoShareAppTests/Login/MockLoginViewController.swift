//
//  MockLoginViewController.swift
//  PhotoShareAppTests
//
//  Created by Berkay Sancar on 30.11.2022.
//

@testable import PhotoShareApp

final class MockLoginViewController: LoginViewProtocol {
    
    func onError(title: String, message: String) {
        
    }
    
    var invokedPrepareSignInWithApple = false
    var invokedPrepareSignInWithAppleCount = 0
    
    func prepareSignInWithApple() {
        invokedPrepareSignInWithApple = true
        invokedPrepareSignInWithAppleCount += 1
    }
    
    var invokedPerformSignInWithApple = false
    var invokedPerformSignInWithAppleCount = 0
    
    func performSignInWithApple() {
        invokedPerformSignInWithApple = true
        invokedPerformSignInWithAppleCount += 1
    }
    
    var invokedPerformSegue = false
    var invokedPerformSegueCount = 0
    var invokedPerformSegueIdentifier: String?
    
    func performSegue(with identifier: String) {
        invokedPerformSegue = true
        invokedPerformSegueCount += 1
        invokedPerformSegueIdentifier = identifier
    }
}
