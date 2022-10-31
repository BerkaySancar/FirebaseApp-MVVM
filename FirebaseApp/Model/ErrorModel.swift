//
//  ErrorModel.swift
//  FotografPaylasmaUygulamasi
//
//  Created by Berkay Sancar on 26.10.2022.
//

import Foundation

enum FirebaseError: String, Error {
    
    case storageError = "Storage error."
    case imageURLDownloadError = "Image URL is inaccessible."
    case postUploadError = "Post is not uploaded."
    case loginError = "Login failed. Incorrect username or password."
    case signUpError = "Sign up failed."
    case signOutError = "Sign out failed. Try again."
    case getPostError = "Posts are not loaded."
    case signInWithAppleError = "Sign in failed. Something went wrong."
}

enum GeneralError: String, Error {
    
    case emptyUsernameOrPasswordError = "Username & password cannot be empty."
    case imageNotSelectedError = "Please select any image..."
    case commentEmptyError = "Please write any comments..."
    case photoPickerError = "Something went wrong. Try again."
}
