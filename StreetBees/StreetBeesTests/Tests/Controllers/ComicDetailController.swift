//
//  ComicDetailController.swift
//  StreetBeesTests
//
//  Created by Roger TAN on 22/07/2018.
//  Copyright © 2018 Roger TAN. All rights reserved.
//

import XCTest
@testable import StreetBees

class ComicDetailControllerTests: XCTestCase {
    
    // MARK: - Tests
    
    func testController_whenViewAppears_imageViewNotNil() {
        subject.beginAppearanceTransition(true, animated: true)
        subject.endAppearanceTransition()
        
        XCTAssertNotNil(subject.imageView)
    }

    func testController_whenViewAppears_CloseButtonNotNil() {
        subject.beginAppearanceTransition(true, animated: true)
        subject.endAppearanceTransition()
        
        XCTAssertNotNil(subject.closeButton)
    }

    // MARK: - XCTestCase
    
    override func setUp() {
        super.setUp()

        model = Faker.comic
        viewModel = ComicViewModel(model: model)
        subject = ComicDetailController(viewModel: viewModel)
        window = UIWindow()
        window.rootViewController = subject
        window.makeKeyAndVisible()
    }
    
    override func tearDown() {
        super.tearDown()

        model = nil
        viewModel = nil
    }
    
    // MARK: - Stored Properties
    
    var model: Comic!
    var subject: ComicDetailController!
    var viewModel: ComicViewModel!
    var window: UIWindow!
}
