//
//  UploadManager.swift
//  FotografPaylasmaUygulamasi
//
//  Created by Berkay Sancar on 24.10.2022.
//

import Foundation
import Firebase

protocol PostManagerProtocol {
    func addDocument(post: [String : Any], completion: @escaping (Result<Void, FirebaseError>) -> Void)
    func getPosts(completion: @escaping (Result<[Post], FirebaseError>) -> Void)
}

final class PostManager: PostManagerProtocol {
    
    static let shared = PostManager()
    
    private let firestoreDatabase = Firestore.firestore()
    private var posts: [Post] = []
    
    private init() {}
}

extension PostManager {
    
// MARK: - Add Document
    func addDocument(post: [String : Any], completion: @escaping (Result<Void, FirebaseError>) -> Void) {
        
        firestoreDatabase.collection("Post").addDocument(data: post) { (error) in
            
            if error != nil {
                completion(.failure(.postUploadError))
            } else {
                completion(.success(()))
            }
        }
    }
// MARK: - Get Posts
    func getPosts(completion: @escaping (Result<[Post], FirebaseError>) -> Void) {
        
        firestoreDatabase
            .collection("Post")
            .order(by: "date", descending: true)
            .addSnapshotListener { [weak self] (snapshot, error) in
                guard let self else { return }
                if error != nil {
                    completion(.failure(.getPostError))
                } else {
                    if let snapshot, !snapshot.isEmpty {
                        self.posts.removeAll(keepingCapacity: false)
                        for document in snapshot.documents {
                            if
                                let imageURL = document.get("imageUrl") as? String,
                                let email = document.get("email") as? String,
                                let comment = document.get("comment") as? String {
                                
                                let post = Post(email: email, comment: comment, imageUrl: imageURL)
                                self.posts.append(post)
                            }
                        }
                        completion(.success(self.posts))
                    }
                }
            }
    }
}
