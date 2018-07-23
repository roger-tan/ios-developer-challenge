//
//  ComicsControllerTest.swift
//  StreetBeesTests
//
//  Created by Roger TAN on 22/07/2018.
//  Copyright © 2018 Roger TAN. All rights reserved.
//

import XCTest
@testable import StreetBees

class ComicsControllerTest: XCTestCase {
    
    // MARK: - Tests
    
    func testCollectionView_whenViewDidLoad_shouldNotBeNil() {
        XCTAssertNotNil(subject.collectionView)
    }
    
    func testController_whenLoaded_conformToUICollectionViewDataSource() {
        XCTAssert(subject.conforms(to: UICollectionViewDataSource.self))
        XCTAssertTrue(subject.responds(to: #selector(subject.collectionView(_:numberOfItemsInSection:))))
        XCTAssertTrue(subject.responds(to: #selector(subject.collectionView(_:cellForItemAt:))))
    }
    
    func testController_whenLoaded_hasSetCollectionViewDataSource() {
        XCTAssertNotNil(subject.collectionView.dataSource)
    }
    
    func testController_whenLoaded_conformToUICollectionViewDelegate() {
        XCTAssert(subject.conforms(to: UICollectionViewDelegate.self))
        XCTAssertTrue(subject.responds(to: #selector(subject.collectionView(_:didSelectItemAt:))))
    }
    
    func testController_whenLoaded_hasSetCollectionViewDelegate() {
        XCTAssertNotNil(subject.collectionView.delegate)
    }
    
    func testController_whenLoaded_conformsToUICollectionViewDelegateFlowLayout() {
        XCTAssert(subject.conforms(to: UICollectionViewDelegateFlowLayout.self))
        XCTAssertTrue(subject.responds(to: #selector(subject.collectionView(_:layout:sizeForItemAt:))))
    }
    
    func testController_whenViewDidLoad_callsViewModelInputsViewDidLoad() {
        subject.beginAppearanceTransition(true, animated: true)
        subject.endAppearanceTransition()
        XCTAssertTrue(viewModel.viewDidLoadCalled)
    }
    
    func testOutputShowDetail_whenSelectedItem_showsDetailScreen() {
        viewModel.comics = [ComicViewModel(model: Faker.comic)]
        viewModel.inputs.select(at: 0)
        expectation(for: NSPredicate(format: "presentedViewController != nil"), evaluatedWith: subject) {
            if self.window.rootViewController?.presentedViewController is ComicDetailController {
                return true
            }
            
            return false
        }
        
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    // MARK: - XCTestCase
    
    override func setUp() {
        super.setUp()
        
        subject = ComicsController()
        viewModel = MockComicsViewModel()
        subject.viewModel = viewModel
        window = UIWindow()
        window.rootViewController = subject
        window.makeKeyAndVisible()
    }
    
    override func tearDown() {
        super.tearDown()
        
        subject = nil
        viewModel = nil
    }
    
    // MARK: - Stored Properties
    
    var subject: ComicsController!
    var viewModel: MockComicsViewModel!
    var window: UIWindow!
}
