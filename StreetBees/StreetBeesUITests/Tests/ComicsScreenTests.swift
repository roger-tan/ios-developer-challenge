//
//  ComicsScreenTests.swift
//  StreetBeesUITests
//
//  Created by Roger TAN on 22/07/2018.
//  Copyright © 2018 Roger TAN. All rights reserved.
//

import XCTest

class ComicsScreenTests: XCTestCase {

    func testScreen_hasExpectedElements() {
        XCTAssertTrue(screens.comics.collectionView.exists)
    }
    
    func testScreen_hasExpectedData() {
        comics().enumerated().forEach { (index, comic) in
            verify(comic: comic, index: index)
        }
    }
    
    func testScreen_whenTappedFirstCell_shouldDisplayComicDetail() {
        screens.comics.cell(at: 0).element.tap()
        
        XCTAssertTrue(screens.comicDetail.view.exists)
    }

    // MARK: - Private Methods
    
    private func verify(comic: String, index: Int, file: StaticString = #file, line: UInt = #line) {
        let cell = screens.comics.cell(at: index)
        
        while !cell.element.isHittable {
            let start = screens.comics.app.coordinate(withNormalizedOffset: CGVector(dx: 0.0, dy: 0.5))
            let end = screens.comics.app.coordinate(withNormalizedOffset: CGVector(dx: 0.1, dy: 0.5))
            start.press(forDuration: 0.0, thenDragTo: end)
        }
        
        XCTAssertEqual(cell.imageURL, comic, file: file, line: line)
    }
    
    private func comics() -> [String] {
        if let path = Bundle(for: type(of: self)).path(forResource: "Comics", ofType: "json"){
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let  jsonDecoder = JSONDecoder()
                let comics = try jsonDecoder.decode([String].self, from: data)
                return comics
            } catch {
                // handle error
            }
        }
        return []
    }
    
    // MARK: - XCTestCase
    
    override func setUp() {
        super.setUp()
        
        screens = Screens()
        XCUIApplication().launch()
        // Ensure that the collection view is loaded
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: screens.comics.collectionView, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Types
    
    struct Screens {
        let comics = ComicsScreen()
        let comicDetail = ComicDetailScreen()
    }
    
    // MARK: - Stored Properties
    
    var screens: Screens!
    
}
