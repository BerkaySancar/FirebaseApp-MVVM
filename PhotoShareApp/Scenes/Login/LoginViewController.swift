//
//  ViewController.swift
//
//  Created by Berkay Sancar on 15.04.2022.
//

import UIKit
import AuthenticationServices

protocol LoginViewDelegate: AnyObject, SeguePerformable {
    
    func onError(title: String, message: String)
    func prepareSignInWithApple()
    func performSignInWithApple()
}

final class LoginViewController: UIViewController {
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var signInWithApple: ASAuthorizationAppleIDButton!
    
    private lazy var viewModel: LoginViewModelProtocol = LoginViewModel(view: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
    }

// MARK: - Sign in Action
    @IBAction func didTapSignIn(_ sender: Any) {
        guard
            let email = emailTextField.text,
            let password = passwordTextField.text
        else { return }
        
        viewModel.didTapSignIn(email: email, password: password)
    }
// MARK: - Login Action
    @IBAction func didTapLogin(_ sender: Any) {
        guard
            let email = emailTextField.text,
            let password = passwordTextField.text
        else { return }
        
        viewModel.didTapLogin(email: email, password: password)
    }
// MARK: - Sign in with Apple
    @objc private func didTapSignInWithApple() {
        viewModel.didTapSignInWithApple()
    }
}
// MARK: - ASAuthorizationControllerDelegate
extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        viewModel.didCompleteWithAuthorization(authorization: authorization)
    }
}
// MARK: - ASAuthorizationControllerPresentationContextProviding
extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
// MARK: - Login View Delegate
extension LoginViewController: LoginViewDelegate {
    
    func prepareSignInWithApple() {
        signInWithApple.addTarget(self, action: #selector(didTapSignInWithApple), for: UIControl.Event.touchUpInside)
    }
    
    func performSignInWithApple() {
        let request = viewModel.createAppleIDRequest()
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        
        authorizationController.performRequests()
    }
 
    func onError(title: String, message: String) {
        self.errorMessage(titleInput: title, messageInput: message)
    }
}
