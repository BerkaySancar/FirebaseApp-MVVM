//
//  FeedViewModel.swift
//
//  Created by Berkay Sancar on 20.10.2022.
//

import Foundation
import FirebaseAuth

protocol FeedViewModelProtocol {
    
    var delegate: FeedViewDelegate? { get set }
    var postArr: [Post] { get set }
    
    func viewDidLoad()
}

final class FeedViewModel: FeedViewModelProtocol {
    
    weak var delegate: FeedViewDelegate?
    
    var postArr: [Post] = []
    
    private func getFirebaseData() {
        self.delegate?.setLoading(isLoading: true)
        
        PostManager.shared.getPosts { [weak self] (results) in
            guard let self else { return }
            self.delegate?.setLoading(isLoading: false)
            switch results {
            case .success(let posts):
                self.postArr = posts
                self.delegate?.dataRefreshed()
            case .failure(let error):
                self.delegate?.onError(title: "Error!", message: error.rawValue)
            }
        }
    }
    
    private func getCurrentUserEmail() {
        guard let email = Auth.auth().currentUser?.email else { return }
        self.delegate?.showCurrentUserEmail(email: email)
    }
    
    func viewDidLoad() {
        self.delegate?.prepareTableView()
        getFirebaseData()
        getCurrentUserEmail()
    }
}
