//
//  MockSettingViewController.swift
//  PhotoShareAppTests
//
//  Created by Berkay Sancar on 1.12.2022.
//

@testable import PhotoShareApp

final class MockSettingViewController: SettingsViewProtocol {
    
    func onError(title: String, message: String) {
        
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
