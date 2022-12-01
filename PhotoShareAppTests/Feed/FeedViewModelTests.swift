//
//  FeedViewModelTests.swift
//  PhotoShareAppTests
//
//  Created by Berkay Sancar on 30.11.2022.
//

import XCTest
@testable import PhotoShareApp

final class FeedViewModelTests: XCTestCase {
    
    private var viewModel: FeedViewModel!
    private var view: MockFeedViewController!
    private var postManager: MockPostManager!
    private var authManager: MockAuthManager!
    
    override func setUp() {
        view = .init()
        postManager = .init()
        authManager = .init()
        viewModel = .init(view: view, postManager: postManager, authManager: authManager)
    }
    
    override func tearDown() {
        view = nil
        postManager = nil
        viewModel = nil
    }
    
    func test_viewDidLoad_InvokesRequiredMethods() {
        //GIVEN
        XCTAssertFalse(view.invokedPrepareTableView)
        XCTAssertFalse(view.invokedBeginRefreshing)
        XCTAssertFalse(postManager.invokedGetPosts)
        XCTAssertFalse(view.invokedEndRefreshing)
        XCTAssertFalse(view.invokedDataRefreshed)
        XCTAssertFalse(view.invokedShowCurrentUserEmail)
        XCTAssertNil(authManager.invokedCurrentUserEmailValue)
        
        //WHEN
        viewModel.viewDidLoad()
        
        //THEN
        XCTAssertEqual(view.invokedPrepareTableViewCount, 1)
        XCTAssertEqual(view.invokedBeginRefreshingCount, 1)
        XCTAssertEqual(postManager.invokedGetPostsCount, 1)
        XCTAssertEqual(view.invokedEndRefreshingCount, 1)
        XCTAssertEqual(view.invokedDataRefreshedCount, 1)
        XCTAssertEqual(view.invokedShowCurrentUserEmailCount, 1)
        XCTAssertEqual(authManager.invokedCurrentUserEmailValue, "test")
    }
}
