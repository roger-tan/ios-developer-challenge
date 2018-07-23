//
//  ComicDetailScreenTests.swift
//  StreetBeesUITests
//
//  Created by Roger TAN on 22/07/2018.
//  Copyright © 2018 Roger TAN. All rights reserved.
//

import XCTest

class ComicDetailScreenTests: XCTestCase {
    
    func testScreen_closeTapped_dismiss() {
        XCTAssertFalse(screen.view.exists)
    }
    
    override func setUp() {
        super.setUp()
        
        screen = ComicDetailScreen()
        
        XCUIApplication().launch()
        ComicsScreen().cell(at: 0).element.tap()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - Stored Properties
    
    var screen: ComicDetailScreen!
}
