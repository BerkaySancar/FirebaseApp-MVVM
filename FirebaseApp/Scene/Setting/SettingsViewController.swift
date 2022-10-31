//
//  SettingsViewController.swift
//  FotografPaylasmaUygulamasi
//
//  Created by Berkay Sancar on 16.04.2022.
//

import UIKit

protocol SettingsViewDelegate: AnyObject, SeguePerformable {
    
    func onError(title: String, message: String)
}

final class SettingsViewController: UIViewController {
    
    private lazy var viewModel: SettingsViewModelProtocol = SettingsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
    }
    
    @IBAction func didTapSignOut(_ sender: Any) {
        
        viewModel.didTapSignOut()
    }
}

//MARK: - SettingsViewDelegate
extension SettingsViewController: SettingsViewDelegate {
    
    func onError(title: String, message: String) {
        self.errorMessage(titleInput: title, messageInput: message)
    }
}
