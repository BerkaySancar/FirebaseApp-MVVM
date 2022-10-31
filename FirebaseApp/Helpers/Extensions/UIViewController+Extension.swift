//
//  UIViewController+Extension.swift
//  FotografPaylasmaUygulamasi
//
//  Created by Berkay Sancar on 30.10.2022.
//

import Foundation
import UIKit.UIViewController

// MARK: - Close keybord when tapped anywhere
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
// MARK: - Error Alert
extension UIViewController {
    
    func errorMessage(titleInput: String, messageInput: String) {
        
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
