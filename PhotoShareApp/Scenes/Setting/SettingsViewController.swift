//
//  SettingsViewController.swift
//
//  Created by Berkay Sancar on 16.04.2022.
//

import UIKit

protocol SettingsViewProtocol: AnyObject, SeguePerformable {
    
    func onError(title: String, message: String)
}

final class SettingsViewController: UIViewController {
    
    private lazy var viewModel: SettingsViewModelProtocol = SettingsViewModel(view: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapSignOut(_ sender: Any) {
        viewModel.didTapSignOut()
    }
}

//MARK: - SettingsViewDelegate
extension SettingsViewController: SettingsViewProtocol {
    
    func onError(title: String, message: String) {
        self.errorMessage(titleInput: title, messageInput: message)
    }
}
