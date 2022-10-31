//
//  SeguePerformable.swift
//  FotografPaylasmaUygulamasi
//
//  Created by Berkay Sancar on 20.10.2022.
//

import UIKit

protocol SeguePerformable {
    
    func performSegue(with identifier: String)
}

extension SeguePerformable where Self: UIViewController {
    
    func performSegue(with identifier: String) {
        performSegue(withIdentifier: identifier, sender: self)
    }
}

enum SegueID: String {
    
    case login = "toLoginVC"
    case feed = "toFeedVC"
}
