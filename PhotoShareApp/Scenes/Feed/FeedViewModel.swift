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
    private let postManager: PostManagerProtocol
    private let authManager: AuthManagerProtocol
    
    var postArr: [Post] = []
    
    init(view: FeedViewProtocol,
         postManager: PostManagerProtocol = PostManager.shared,
         authManager: AuthManagerProtocol = AuthManager.shared) {
        self.view = view
        self.postManager = postManager
        self.authManager = authManager
    }
    
    private func getFirebaseData() {
        self.view?.beginRefreshing()
        postManager.getPosts { [weak self] (results) in
            guard let self else { return }
            switch results {
            case .success(let posts):
                self.postArr = posts
                self.view?.endRefreshing()
                self.view?.dataRefreshed()
            case .failure(let error):
                self.view?.onError(title: "Error!", message: error.rawValue)
            }
        }
    }
    
    func getCurrentUserEmail() {
        self.view?.showCurrentUserEmail(email: authManager.showCurrentUserEmail())
    }
    
    func viewDidLoad() {
        self.view?.prepareTableView()
        getFirebaseData()
        getCurrentUserEmail()
    }
}
