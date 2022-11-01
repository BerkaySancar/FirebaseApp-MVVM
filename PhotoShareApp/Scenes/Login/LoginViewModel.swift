//
//  LoginViewModel.swift
//
//  Created by Berkay Sancar on 20.10.2022.
//

import Foundation
import AuthenticationServices

protocol LoginViewModelProtocol {
    
    var delegate: LoginViewDelegate? { get set }
    
    func didTapSignIn(email: String, password: String)
    func didTapLogin(email: String, password: String)
    func didTapSignInWithApple()
    func createAppleIDRequest() -> ASAuthorizationAppleIDRequest
    func didCompleteWithAuthorization(authorization: ASAuthorization)
    func viewDidLoad()
}

final class LoginViewModel: LoginViewModelProtocol {
    
    weak var delegate: LoginViewDelegate?
    private var currentNonce: String?

// MARK: - Sign in button Action
    func didTapSignIn(email: String, password: String) {
        if email.isEmpty, password.isEmpty {
            self.delegate?.onError(title: "Error!", message: GeneralError.emptyUsernameOrPasswordError.rawValue)
        } else {
            LoginSignUpManager.shared.signUp(email: email, password: password) { results in
                switch results {
                case .failure(let error):
                    self.delegate?.onError(title: "Error!", message: error.rawValue)
                case .success(let segueID):
                    self.delegate?.performSegue(with: segueID)
                }
            }
        }
    }
    
// MARK: - Login Button Action
    func didTapLogin(email: String, password: String) {
        if !email.isEmpty, !password.isEmpty {
            LoginSignUpManager.shared.login(email: email, password: password) { results in
                switch results {
                case .failure(let error):
                    self.delegate?.onError(title: "Error!", message: error.rawValue)
                case .success(let segueID):
                    self.delegate?.performSegue(with: segueID)
                }
            }
        } else {
            self.delegate?.onError(title: "Error!", message: GeneralError.emptyUsernameOrPasswordError.rawValue)
        }
    }
// MARK: - APPLE SIGN IN LOGICS
    func didTapSignInWithApple() {
        self.delegate?.performSignIn()
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
        
            let credential = LoginSignUpManager.shared.createCredential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
            
            LoginSignUpManager.shared.signInWithApple(credential: credential) { (results) in
                switch results {
                case .failure(let error):
                    self.delegate?.onError(title: "Error!", message: error.rawValue)
                case .success(let segueID):
                    self.delegate?.performSegue(with: segueID)
                }
            }
        }
    }
  
// MARK: - View did load
    func viewDidLoad() {
        self.delegate?.prepareSignInWithApple()
    }
}
