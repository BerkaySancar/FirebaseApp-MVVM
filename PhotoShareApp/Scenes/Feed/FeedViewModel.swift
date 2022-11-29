//
//  FeedViewModel.swift
//
//  Created by Berkay Sancar on 20.10.2022.
//

import Foundation
import FirebaseAuth

protocol FeedViewModelProtocol {
    
    var postArr: [Post] { get set }
    
    func viewDidLoad()
}

final class FeedViewModel: FeedViewModelProtocol {
    
    private weak var view: FeedViewProtocol?
    
    var postArr: [Post] = []
    
    init(view: FeedViewProtocol) {
        self.view = view
    }
    
    private func getFirebaseData() {
        self.view?.setLoading(isLoading: true)
        
        PostManager.shared.getPosts { [weak self] (results) in
            guard let self else { return }
            self.view?.setLoading(isLoading: false)
            switch results {
            case .success(let posts):
                self.postArr = posts
                self.view?.dataRefreshed()
            case .failure(let error):
                self.view?.onError(title: "Error!", message: error.rawValue)
            }
        }
    }
    
    private func getCurrentUserEmail() {
        guard let email = Auth.auth().currentUser?.email else { return }
        self.view?.showCurrentUserEmail(email: email)
    }
    
    func viewDidLoad() {
        self.view?.prepareTableView()
        getFirebaseData()
        getCurrentUserEmail()
    }
}
