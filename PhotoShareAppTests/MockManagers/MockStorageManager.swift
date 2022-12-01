//
//  MockStorageManager.swift
//  PhotoShareAppTests
//
//  Created by Berkay Sancar on 30.11.2022.
//

import Foundation
@testable import PhotoShareApp

final class MockStorageManager: StorageManagerProtocol {
    
    var invokedImageStorage = false
    var invokedImageStorageCount = 0
    
    func imageStorage(uuidString: String, image: Data, completion: @escaping (Result<Void, PhotoShareApp.FirebaseError>) -> Void) {
        invokedImageStorage = true
        invokedImageStorageCount += 1
        completion(.success(()))
    }
    
    var invokedDownloadImageUrl = false
    var invokedDownloadImageUrlCount = 0
    
    func downloadImageURL(uuidString: String, completion: @escaping (Result<String, PhotoShareApp.FirebaseError>) -> Void) {
        invokedDownloadImageUrl = true
        invokedDownloadImageUrlCount += 1
        completion(.success(""))
    }
}
