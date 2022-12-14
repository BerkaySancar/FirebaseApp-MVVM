//
//  SettingsViewModel.swift
//
//  Created by Berkay Sancar on 20.10.2022.
//

import Foundation
import Firebase

protocol SettingsViewModelProtocol {
    
    func didTapSignOut()
}

final class SettingsViewModel: SettingsViewModelProtocol {
    
    private weak var view: SettingsViewProtocol?
    private let authManager: AuthManagerProtocol
    
    init(view: SettingsViewProtocol, authManager: AuthManagerProtocol = AuthManager.shared) {
        self.view = view
        self.authManager = authManager
    }
    
    func didTapSignOut() {
        authManager.signOut { results in
            switch results {
            case .success(let segueID):
                self.view?.performSegue(with: segueID)
            case .failure(let error):
                self.view?.onError(title: "Error!", message: error.rawValue)
            }
        }
    }
}
