//
//  StorageManager.swift
//  FotografPaylasmaUygulamasi
//
//  Created by Berkay Sancar on 24.10.2022.
//

import Foundation
import Firebase

protocol StorageManagerProtocol {
    func imageStorage(uuidString: String, image: Data, completion: @escaping (Result<Void, FirebaseError>) -> Void)
    func downloadImageURL(uuidString: String, completion: @escaping (Result<String, FirebaseError>) -> Void)
}

struct StorageManager: StorageManagerProtocol {
    
    static let shared = StorageManager()

    private let mediaFolderImageReference = Storage.storage().reference().child("media")
    
    private init() {}
}

extension StorageManager {
    
// MARK: - Image Storage
    func imageStorage(uuidString: String, image: Data, completion: @escaping (Result<Void, FirebaseError>) -> Void) {
        
        mediaFolderImageReference.child("\(uuidString).jpg").putData(image, metadata: nil) { (_, error) in
            if error != nil {
                completion(.failure(.storageError))
            } else {
                completion(.success(()))
            }
        }
    }
// MARK: - DownloadImageURL
    func downloadImageURL(uuidString: String, completion: @escaping (Result<String, FirebaseError>) -> Void) {
        
        mediaFolderImageReference.child("\(uuidString).jpg").downloadURL { url, error in
            
            if error != nil {
                completion(.failure(.imageURLDownloadError))
            } else {
                guard let urlString = url?.absoluteString else { return }
                completion(.success(urlString))
            }
        }
    }
}
