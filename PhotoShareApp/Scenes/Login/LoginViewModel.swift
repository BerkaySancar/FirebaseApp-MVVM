//
//  LoginViewModel.swift
//
//  Created by Berkay Sancar on 20.10.2022.
//

import Foundation
import AuthenticationServices
import FirebaseAuth

protocol LoginViewModelProtocol {
    
    func didTapSignIn(email: String, password: String)
    func didTapLogin(email: String, password: String)
    func didTapSignInWithApple()
    func createAppleIDRequest() -> ASAuthorizationAppleIDRequest
    func didCompleteWithAuthorization(authorization: ASAuthorization)
    func viewDidLoad()
}

final class LoginViewModel: LoginViewModelProtocol {
    
    private weak var view: LoginViewProtocol?
    private let authManager: AuthManagerProtocol
    private var currentNonce: String?
    
    init(view: LoginViewProtocol,
         authManager: AuthManagerProtocol = AuthManager.shared) {
        self.view = view
        self.authManager = authManager
    }

// MARK: - Sign in button Action
    func didTapSignIn(email: String, password: String) {
        if email.isEmpty, password.isEmpty {
            self.view?.onError(title: "Error!", message: GeneralError.emptyUsernameOrPasswordError.rawValue)
        } else {
            authManager.signUp(email: email, password: password) { results in
                switch results {
                case .failure(let error):
                    self.view?.onError(title: "Error!", message: error.rawValue)
                case .success(let segueID):
                    self.view?.performSegue(with: segueID)
                }
            }
        }
    }
    
// MARK: - Login Button Action
    func didTapLogin(email: String, password: String) {
        if !email.isEmpty, !password.isEmpty {
            authManager.login(email: email, password: password) { results in
                switch results {
                case .failure(let error):
                    self.view?.onError(title: "Error!", message: error.rawValue)
                case .success(let segueID):
                    self.view?.performSegue(with: segueID)
                }
            }
        } else {
            self.view?.onError(title: "Error!", message: GeneralError.emptyUsernameOrPasswordError.rawValue)
        }
    }
// MARK: - APPLE SIGN IN LOGICS
    func didTapSignInWithApple() {
        self.view?.performSignInWithApple()
    }
    
    func createAppleIDRequest() -> ASAuthorizationAppleIDRequest {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let nonce = RandomNonceString.create()
        request.nonce = SHA.sha256(nonce)
        self.currentNonce = nonce
        
        return request
    }
    
    private func createCredential(withProviderID: String, idToken: String, rawNonce: String) -> OAuthCredential {
        let credential = OAuthProvider.credential(withProviderID: withProviderID, idToken: idToken, rawNonce: rawNonce)
        return credential
    }
    
    func didCompleteWithAuthorization(authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token.")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
        
            let credential = createCredential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
            
            authManager.signInWithApple(credential: credential) { (results) in
                switch results {
                case .failure(let error):
                    self.view?.onError(title: "Error!", message: error.rawValue)
                case .success(let segueID):
                    self.view?.performSegue(with: segueID)
                }
            }
        }
    }
  
// MARK: - View did load
    func viewDidLoad() {
        self.view?.prepareSignInWithApple()
    }
}
