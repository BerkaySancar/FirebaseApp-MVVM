//
//  MockAuthManager.swift
//  PhotoShareAppTests
//
//  Created by Berkay Sancar on 30.11.2022.
//

@testable import PhotoShareApp
import FirebaseAuth

final class MockAuthManager: AuthManagerProtocol {
    
    var invokedLogin = false
    var invokedLoginCount = 0
    
    func login(email: String, password: String, completion: @escaping (Result<String, PhotoShareApp.FirebaseError>) -> Void) {
        invokedLogin = true
        invokedLoginCount += 1
        completion(.success(SegueID.feed.rawValue))
    }
    
    var invokedSignUp = false
    var invokedSignUpCount = 0
    
    func signUp(email: String, password: String, completion: @escaping (Result<String, PhotoShareApp.FirebaseError>) -> Void) {
        invokedSignUp = true
        invokedSignUpCount += 1
        completion(.success(SegueID.feed.rawValue))
    }
    
    var invokedSignInWithApple = false
    var invokedSignInWithAppleCount = 0
    
    func signInWithApple(credential: OAuthCredential, completion: @escaping (Result<String, PhotoShareApp.FirebaseError>) -> Void) {
        invokedSignInWithApple = true
        invokedSignInWithAppleCount += 1
    }
    
    var invokedSignOut = false
    var invokedSignOutCount = 0
    
    func signOut(completion: @escaping (Result<String, PhotoShareApp.FirebaseError>) -> Void) {
        invokedSignOut = true
        invokedSignOutCount += 1
        completion(.success(SegueID.login.rawValue))
    }
    
    var invokedCurrentUserEmail = false
    var invokedCurrentUserEmailCount = 0
    var invokedCurrentUserEmailValue: String?
    
    func showCurrentUserEmail() -> String {
        invokedCurrentUserEmail = true
        invokedCurrentUserEmailCount += 1
        invokedCurrentUserEmailValue = "test"
        return ""
    }
}
