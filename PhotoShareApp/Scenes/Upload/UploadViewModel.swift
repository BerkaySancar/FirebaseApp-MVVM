//
//  UploadViewModel.swift
//
//  Created by Berkay Sancar on 21.10.2022.
//

import Foundation
import Firebase

protocol UploadViewModelProtocol {
    
    var delegate: UploadViewDelegate? { get set }
    
    func didTapUploadButton(data: Data, comment: String)
    func didTapImage()
    func viewDidLoad()
}

final class UploadViewModel: UploadViewModelProtocol {
    
    weak var delegate: UploadViewDelegate?
    
    private var post: [String : Any] = [:]
    
// MARK: - Did Tap Upload Button
    func didTapUploadButton(data: Data, comment: String) {
        
        let uuidString = UUID().uuidString
        
        if comment.isEmpty {
            self.delegate?.onError(title: "Error!", message: GeneralError.commentEmptyError.rawValue)
        } else {
            self.delegate?.setLoading(isLoading: true)
            StorageManager.shared.imageStorage(uuidString: uuidString, image: data) { results in
                switch results {
                case .failure(let failure):
                    self.delegate?.onError(title: "Error!", message: failure.rawValue)
                case .success(_):
                    StorageManager.shared.downloadImageURL(uuidString: uuidString) { results in
                        switch results {
                        case .failure(let error):
                            self.delegate?.onError(title: "Error!", message: error.rawValue)
                        case .success(let url):
                            self.post["imageUrl"] = url
                            self.post["comment"] = comment
                            self.post["email"] = Auth.auth().currentUser?.email
                            self.post["date"] = FieldValue.serverTimestamp()
                            
                            PostManager.shared.addDocument(post: self.post) { [weak self] results in
                                guard let self else { return }
                                switch results {
                                case .failure(let error):
                                    self.delegate?.onError(title: "Error!", message: error.rawValue)
                                case .success(_):
                                    self.delegate?.setLoading(isLoading: false)
                                    self.delegate?.uploadSuccess()
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
        self.delegate?.configure()
        self.delegate?.setLoading(isLoading: false)
        self.delegate?.prepareImagePicker()
    }
    
// MARK: - didTapImage
    func didTapImage() {
        self.delegate?.presentImagePicker()
    }
}
