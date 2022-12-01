//
//  MockPostManager.swift
//  PhotoShareAppTests
//
//  Created by Berkay Sancar on 30.11.2022.
//

@testable import PhotoShareApp

final class MockPostManager: PostManagerProtocol {
    
    var invokedAddDocument = false
    var invokedAddDocumentCount = 0
    
    func addDocument(post: [String : Any], completion: @escaping (Result<Void, PhotoShareApp.FirebaseError>) -> Void) {
        invokedAddDocument = true
        invokedGetPostsCount += 1
        completion(.success(()))
    }
    
    var invokedGetPosts = false
    var invokedGetPostsCount = 0
    
    func getPosts(completion: @escaping (Result<[PhotoShareApp.Post], PhotoShareApp.FirebaseError>) -> Void) {
        invokedGetPosts = true
        invokedGetPostsCount += 1
        completion(.success([]))
    }
}
