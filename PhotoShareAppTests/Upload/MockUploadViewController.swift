//
//  MockUploadViewController.swift
//  PhotoShareAppTests
//
//  Created by Berkay Sancar on 30.11.2022.
//

@testable import PhotoShareApp

final class MockUploadViewController: UploadViewProtocol {
    
    func onError(title: String, message: String) {
        
    }
    
    var invokedBeginRefreshing = false
    var invokedBeginRefreshingCount = 0
    
    func beginRefreshing() {
        invokedBeginRefreshing = true
        invokedBeginRefreshingCount += 1
    }
    
    var invokedEndRefreshing = false
    var invokedEndRefreshingCount = 0
    
    func endRefreshing() {
        invokedEndRefreshing = true
        invokedEndRefreshingCount += 1
    }
    
    var invokedConfigure = false
    var invokedConfigureCount = 0
    
    func configure() {
        invokedConfigure = true
        invokedConfigureCount += 1
        
    }
    
    var invokedPrepareImagePicker = false
    var invokedPrepareImagePickerCount = 0
    
    func prepareImagePicker() {
        invokedPrepareImagePicker = true
        invokedPrepareImagePickerCount += 1
    }
    
    var invokedPresentImagePicker = false
    var invokedPresentImagePickerCount = 0
    
    func presentImagePicker() {
        invokedPresentImagePicker = true
        invokedPresentImagePickerCount += 1
    }
    
    var invokedUploadSuccess = false
    var invokedUploadSuccessCount = 0
    
    func uploadSuccess() {
        invokedUploadSuccess = true
        invokedUploadSuccessCount += 1
    }
    
    func performSegue(with identifier: String) {
        
    }
}
