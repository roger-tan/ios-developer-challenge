//
//  ComicsViewModelTests.swift
//  StreetBeesTests
//
//  Created by Roger TAN on 22/07/2018.
//  Copyright © 2018 Roger TAN. All rights reserved.
//

import XCTest
@testable import StreetBees

class ComicsViewModelTests: XCTestCase {
    
    // MARK: - Test Cases
    
    func testFetch_whenSuccessful_callbackReloadData() {
        let expectation = self.expectation(description: "Reload data")
        client.fetchComics = { (completion) in
            completion([], nil)
        }
        subject.reloadData = { () in
            expectation.fulfill()
        }
        subject.viewDidLoad()
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }

    func testNumberOfRows_hasExpectedNumberRows() {
        let expectation = self.expectation(description: "Number of rows")
        client.fetchComics = { (completion) in
            completion([Faker.comic, Faker.comic], nil)
            expectation.fulfill()
        }
        subject.viewDidLoad()
        
        XCTAssertEqual(subject.numberOfRows(), 2)
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testComicAtIndex_hasExpectedComicViewModel() {
        let expectation = self.expectation(description: "Comic")
        let comic = Faker.comic
        client.fetchComics = { (completion) in
            completion([comic], nil)
            expectation.fulfill()
        }
        subject.viewDidLoad()
        let expected = ComicViewModel(model: comic)
        
        XCTAssertEqual(subject.comic(at: 0), expected)
        waitForExpectations(timeout: 0.1, handler: nil)
    }

    func testSelect_whenCalled_emitsShowDetail() {
        let expectation = self.expectation(description: "Show detail")
        let comic = Faker.comic
        let expected = ComicViewModel(model: comic)
        
        client.fetchComics = { (completion) in
            completion([comic], nil)
        }
        subject.showComicDetail = { comic in
            XCTAssertEqual(expected, comic)
            expectation.fulfill()
            
        }
        subject.viewDidLoad()
        subject.select(at: 0)
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    // MARK: - XCTestCase
    
    override func setUp() {
        super.setUp()
        
        client = MockMarvelClient()
        subject = ComicsViewModel(client: client)
    }
    
    override func tearDown() {
        super.tearDown()
        
        client = nil
        subject = nil
    }
    
    // MARK: - Stored Properties
    
    var client: MockMarvelClient!
    var subject: ComicsViewModel!
    
}

