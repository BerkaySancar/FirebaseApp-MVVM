//
//  SettingViewModelTests.swift
//  PhotoShareAppTests
//
//  Created by Berkay Sancar on 1.12.2022.
//

@testable import PhotoShareApp
import XCTest

final class SettingViewModelTests: XCTestCase {
    
    private var view: MockSettingViewController!
    private var viewModel: SettingsViewModel!
    private var authManager: MockAuthManager!
    
    override func setUp() {
        super.setUp()
        
        view = .init()
        authManager = .init()
        viewModel = .init(view: view, authManager: authManager)
    }
    
    override func tearDown() {
        super.tearDown()
        
        view = nil
        authManager = nil
        viewModel = nil
    }
    
    func test_didTapSignOut_PerformSegue() {
        XCTAssertFalse(authManager.invokedSignOut)
        XCTAssertFalse(view.invokedPerformSegue)
        XCTAssertNil(view.invokedPerformSegueIdentifier)
        
        viewModel.didTapSignOut()
        
        XCTAssertEqual(authManager.invokedSignOutCount, 1)
        XCTAssertEqual(view.invokedPerformSegueCount, 1)
        XCTAssertEqual(view.invokedPerformSegueIdentifier, SegueID.login.rawValue)
    }
}
