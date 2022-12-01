//
//  UploadViewModel.swift
//
//  Created by Berkay Sancar on 21.10.2022.
//

import Foundation
import Firebase

protocol UploadViewModelProtocol {
    
    func didTapUploadButton(data: Data, comment: String)
    func didTapImage()
    func viewDidLoad()
}

final class UploadViewModel: UploadViewModelProtocol {
    
    private weak var view: UploadViewProtocol?
    private let storageManager: StorageManagerProtocol
    private let postManager: PostManagerProtocol
    
    private var post: [String : Any] = [:]
    
    init(view: UploadViewProtocol,
         storageManager: StorageManagerProtocol = StorageManager.shared,
         postManager: PostManagerProtocol = PostManager.shared) {
        self.view = view
        self.storageManager = storageManager
        self.postManager = postManager
    }
    
// MARK: - Did Tap Upload Button
    func didTapUploadButton(data: Data, comment: String) {
        let uuidString = UUID().uuidString
        
        if comment.isEmpty {
            self.view?.onError(title: "Error!", message: GeneralError.commentEmptyError.rawValue)
        } else {
            self.view?.beginRefreshing()
            storageManager.imageStorage(uuidString: uuidString, image: data) { results in
                switch results {
                case .failure(let failure):
                    self.view?.onError(title: "Error!", message: failure.rawValue)
                case .success(_):
                    self.storageManager.downloadImageURL(uuidString: uuidString) { results in
                        switch results {
                        case .failure(let error):
                            self.view?.onError(title: "Error!", message: error.rawValue)
                        case .success(let url):
                            self.post["imageUrl"] = url
                            self.post["comment"] = comment
                            self.post["email"] = Auth.auth().currentUser?.email
                            self.post["date"] = FieldValue.serverTimestamp()
                            
                            self.postManager.addDocument(post: self.post) { [weak self] results in
                                guard let self else { return }
                                switch results {
                                case .failure(let error):
                                    self.view?.onError(title: "Error!", message: error.rawValue)
                                case .success(_):
                                    self.view?.endRefreshing()
                                    self.view?.uploadSuccess()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
// MARK: - viewDidLoad
    func viewDidLoad() {
        self.view?.configure()
        self.view?.endRefreshing()
        self.view?.prepareImagePicker()
    }
    
// MARK: - didTapImage
    func didTapImage() {
        self.view?.presentImagePicker()
    }
}
