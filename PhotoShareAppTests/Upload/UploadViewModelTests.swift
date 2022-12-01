//
//  UploadViewModelTests.swift
//  PhotoShareAppTests
//
//  Created by Berkay Sancar on 30.11.2022.
//

import XCTest
@testable import PhotoShareApp

final class UploadViewModelTests: XCTestCase {
    
    private var view: MockUploadViewController!
    private var viewModel: UploadViewModel!
    private var postManager: MockPostManager!
    private var storageManager: MockStorageManager!
    
    override func setUp() {
        super.setUp()
        
        view = .init()
        postManager = .init()
        storageManager = .init()
        viewModel = .init(view: view, storageManager: storageManager, postManager: postManager)
    }
    
    override func tearDown() {
        super.tearDown()
        
        view = nil
        postManager = nil
        storageManager = nil
        viewModel = nil
    }
    
    func test_viewDidLoad_InvokesRequiredMethods() {
        XCTAssertFalse(view.invokedConfigure)
        XCTAssertFalse(view.invokedEndRefreshing)
        XCTAssertFalse(view.invokedPrepareImagePicker)
        
        viewModel.viewDidLoad()
        
        XCTAssertEqual(view.invokedConfigureCount, 1)
        XCTAssertEqual(view.invokedEndRefreshingCount, 1)
        XCTAssertEqual(view.invokedPrepareImagePickerCount, 1)
    }
    
    func test_didTapImage_InvokesPresentImagePickerMethod() {
        XCTAssertFalse(view.invokedPresentImagePicker)
        
        viewModel.didTapImage()
        
        XCTAssertEqual(view.invokedPresentImagePickerCount, 1)
    }
    
    func test_didTapUploadButton_InvokesRequiredMethods() {
        XCTAssertFalse(view.invokedBeginRefreshing)
        XCTAssertFalse(storageManager.invokedImageStorage)
        XCTAssertFalse(storageManager.invokedDownloadImageUrl)
        XCTAssertFalse(postManager.invokedAddDocument)
        XCTAssertFalse(view.invokedEndRefreshing)
        XCTAssertFalse(view.invokedUploadSuccess)
        
        viewModel.didTapUploadButton(data: Data(count: 0), comment: "test")
        
        XCTAssertEqual(view.invokedBeginRefreshingCount, 1)
        XCTAssertEqual(storageManager.invokedImageStorageCount, 1)
        XCTAssertEqual(storageManager.invokedDownloadImageUrlCount, 1)
        XCTAssertEqual(view.invokedEndRefreshingCount, 1)
        XCTAssertEqual(view.invokedUploadSuccessCount, 1)
    }
}
