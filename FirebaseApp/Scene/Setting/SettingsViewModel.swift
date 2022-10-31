//
//  SettingsViewModel.swift
//  FotografPaylasmaUygulamasi
//
//  Created by Berkay Sancar on 20.10.2022.
//

import Foundation
import Firebase

protocol SettingsViewModelProtocol {
    
    var delegate: SettingsViewDelegate? { get set }
    
    func didTapSignOut()
}

final class SettingsViewModel: SettingsViewModelProtocol {
    
    weak var delegate: SettingsViewDelegate?
    
    func didTapSignOut() {
        
        LoginSignUpManager.shared.signOut { results in
            switch results {
            case .success(let segueID):
                self.delegate?.performSegue(with: segueID)
            case .failure(let error):
                self.delegate?.onError(title: "Error!", message: error.rawValue)
            }
        }
    }
}
