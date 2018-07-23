//
//  ComicViewModelTests.swift
//  StreetBeesTests
//
//  Created by Roger TAN on 22/07/2018.
//  Copyright © 2018 Roger TAN. All rights reserved.
//

import XCTest
@testable import StreetBees

class ComicViewModelTests: XCTestCase {
    
    // MARK - Test Cases
    
    func testThumbnail_hasExpectedURL() {
        let expected = URL(string: "\(model.thumbnail.path)/portrait_medium.\(model.thumbnail.extension)")!
        
        XCTAssertEqual(subject.thumbnail, expected)
    }
    
    func testImage_hasExpectedURL() {
        let expected = URL(string: "\(model.thumbnail.path)/portrait_uncanny.\(model.thumbnail.extension)")!
        
        XCTAssertEqual(subject.image, expected)
    }
    
    // MARK: - XCTestCase
    
    override func setUp() {
        super.setUp()
        
        model = Faker.comic
        subject = ComicViewModel(model: model)
    }
    
    override func tearDown() {
        super.tearDown()
        model = nil
        subject = nil
    }
    
    // MARK: - Stored Properties
    
    var model: Comic!
    var subject: ComicViewModel!
    
}
