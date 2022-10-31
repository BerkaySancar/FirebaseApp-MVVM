//
//  LogInManager.swift
//  FotografPaylasmaUygulamasi
//
//  Created by Berkay Sancar on 26.10.2022.
//

import Foundation
import Firebase

protocol LoginSignUpManagerProtocol {
    func login(email: String, password: String, completion: @escaping (Result<String, FirebaseError>) -> Void)
    func signUp(email: String, password: String, completion: @escaping (Result<String, FirebaseError>) -> Void)
    func signInWithApple(credential: OAuthCredential, completion: @escaping (Result<String, FirebaseError>) -> Void)
    func signOut(completion: @escaping (Result<String, FirebaseError>) -> Void)
}

struct LoginSignUpManager: LoginSignUpManagerProtocol {
    
    static let shared = LoginSignUpManager()
    
    private let auth = Auth.auth()
    
    private init() {}
}

extension LoginSignUpManager {
    
// MARK: - Login with email
    func login(email: String, password: String, completion: @escaping (Result<String, FirebaseError>) -> Void) {
        self.auth.signIn(withEmail: email, password: password) { (_, error) in
            if error != nil {
                completion(.failure(.loginError))
            } else {
                completion(.success(SegueID.feed.rawValue))
            }
        }
    }
// MARK: - Sign up with email
    func signUp(email: String, password: String, completion: @escaping (Result<String, FirebaseError>) -> Void) {
        self.auth.createUser(withEmail: email, password: password) {(_, error) in
            if error != nil {
                completion(.failure(.signUpError))
            } else {
                completion(.success(SegueID.feed.rawValue))
            }
        }
    }
    
// MARK: - Sign in with Apple
    func signInWithApple(credential: OAuthCredential, completion: @escaping (Result<String, FirebaseError>) -> Void) {
        self.auth.signIn(with: credential) { (_, error) in
            if error != nil {
                completion(.failure(.signInWithAppleError))
            } else {
                completion(.success(SegueID.feed.rawValue))
            }
        }
    }
    
    func createCredential(withProviderID: String, idToken: String, rawNonce: String) -> OAuthCredential {
        let credential = OAuthProvider.credential(withProviderID: withProviderID, idToken: idToken, rawNonce: rawNonce)
        return credential
    }

// MARK: - Sign out
    func signOut(completion: @escaping (Result<String, FirebaseError>) -> Void) {
        do {
            try self.auth.signOut()
            completion(.success(SegueID.login.rawValue))
        } catch {
            completion(.failure(.signOutError))
        }
    }
}
