//
//  StorageManager.swift
//  FotografPaylasmaUygulamasi
//
//  Created by Berkay Sancar on 24.10.2022.
//

import Foundation
import Firebase

protocol StorageManagerProtocol {
    func imageStorage(image: Data, completion: @escaping (Result<Void, FirebaseError>) -> Void)
    func downloadImageURL(completion: @escaping (Result<String, FirebaseError>) -> Void)
}

struct StorageManager: StorageManagerProtocol {
    
    static let shared = StorageManager()
    
    private let mediaFolderImageReference = Storage.storage().reference().child("media").child("\(UUID().uuidString).jpg")
    
    private init() {}
}

extension StorageManager {
    
// MARK: - Image Storage
    func imageStorage(image: Data, completion: @escaping (Result<Void, FirebaseError>) -> Void) {
        
        mediaFolderImageReference.putData(image, metadata: nil) { (_, error) in
            if error != nil {
                completion(.failure(.storageError))
            } else {
                completion(.success(()))
            }
        }
    }
// MARK: - DownloadImageURL
    func downloadImageURL(completion: @escaping (Result<String, FirebaseError>) -> Void) {
        
        mediaFolderImageReference.downloadURL { url, error in
            
            if error != nil {
                completion(.failure(.imageURLDownloadError))
            } else {
                guard let urlString = url?.absoluteString else { return }
                completion(.success(urlString))
            }
        }
    }
}
