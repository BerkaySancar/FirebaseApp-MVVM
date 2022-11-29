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
    
    private var post: [String : Any] = [:]
    
    init(view: UploadViewProtocol) {
        self.view = view
    }
    
// MARK: - Did Tap Upload Button
    func didTapUploadButton(data: Data, comment: String) {
        
        let uuidString = UUID().uuidString
        
        if comment.isEmpty {
            self.view?.onError(title: "Error!", message: GeneralError.commentEmptyError.rawValue)
        } else {
            self.view?.setLoading(isLoading: true)
            StorageManager.shared.imageStorage(uuidString: uuidString, image: data) { results in
                switch results {
                case .failure(let failure):
                    self.view?.onError(title: "Error!", message: failure.rawValue)
                case .success(_):
                    StorageManager.shared.downloadImageURL(uuidString: uuidString) { results in
                        switch results {
                        case .failure(let error):
                            self.view?.onError(title: "Error!", message: error.rawValue)
                        case .success(let url):
                            self.post["imageUrl"] = url
                            self.post["comment"] = comment
                            self.post["email"] = Auth.auth().currentUser?.email
                            self.post["date"] = FieldValue.serverTimestamp()
                            
                            PostManager.shared.addDocument(post: self.post) { [weak self] results in
                                guard let self else { return }
                                switch results {
                                case .failure(let error):
                                    self.view?.onError(title: "Error!", message: error.rawValue)
                                case .success(_):
                                    self.view?.setLoading(isLoading: false)
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
        self.view?.setLoading(isLoading: false)
        self.view?.prepareImagePicker()
    }
    
// MARK: - didTapImage
    func didTapImage() {
        self.view?.presentImagePicker()
    }
}
