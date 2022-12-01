//
//  MockFeedViewController.swift
//  PhotoShareAppTests
//
//  Created by Berkay Sancar on 30.11.2022.
//

@testable import PhotoShareApp

final class MockFeedViewController: FeedViewProtocol {
    
    // MARK: - begin refreshing
    var invokedBeginRefreshing = false
    var invokedBeginRefreshingCount = 0
    
    func beginRefreshing() {
        invokedBeginRefreshing = true
        invokedBeginRefreshingCount += 1
    }
    // MARK: - end refreshing
    var invokedEndRefreshing = false
    var invokedEndRefreshingCount = 0
    
    func endRefreshing() {
        invokedEndRefreshing = true
        invokedEndRefreshingCount += 1
    }
    // MARK: - dataRefreshed
    var invokedDataRefreshed = false
    var invokedDataRefreshedCount = 0
    
    func dataRefreshed() {
        invokedDataRefreshed = true
        invokedDataRefreshedCount += 1
    }
    // MARK: - onError
    func onError(title: String, message: String) {
        
    }
    // MARK: - prepareTableView
    var invokedPrepareTableView = false
    var invokedPrepareTableViewCount = 0
    
    func prepareTableView() {
        invokedPrepareTableView = true
        invokedPrepareTableViewCount += 1
    }
    
    // MARK: - showCurrentUserEmail
    var invokedShowCurrentUserEmail = false
    var invokedShowCurrentUserEmailCount = 0
    
    func showCurrentUserEmail(email: String) {
        invokedShowCurrentUserEmail = true
        invokedShowCurrentUserEmailCount += 1
    }
}
