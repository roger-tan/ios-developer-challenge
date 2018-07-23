//
//  ComicsScreen.swift
//  StreetBeesUITests
//
//  Created by Roger TAN on 22/07/2018.
//  Copyright © 2018 Roger TAN. All rights reserved.
//

import XCTest

struct ComicsScreen {
    
    // MARK: - Types
    
    struct Cell {
        var element: XCUIElement
        
        var imageURL: String? {
            return element.images["image"].value as? String
        }
    }
    
    
    // MARK: - UI Elements
    
    var view: XCUIElement {
        return app.otherElements["comics"]
    }
    
    var collectionView: XCUIElement {
        return view.collectionViews.element(boundBy: 0)
    }
    
    // MARK: - Public Methods
    
    func cell(at index: Int) -> Cell {
        return Cell(element: collectionView.cells.matching(identifier: "comic").element(boundBy: index))
    }
    
    
    var app: XCUIApplication {
        return XCUIApplication()
    }
    
}
