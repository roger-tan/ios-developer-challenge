//
//  ComicDetailScreen.swift
//  StreetBeesUITests
//
//  Created by Roger TAN on 22/07/2018.
//  Copyright © 2018 Roger TAN. All rights reserved.
//

import XCTest

struct ComicDetailScreen {
    
    
    // MARK: - UI Elements
    
    var view: XCUIElement {
        return app.otherElements["comic_detail"]
    }
    
    var closeButton: XCUIElement {
        return view.buttons["close"]
    }
    
    var app: XCUIApplication {
        return XCUIApplication()
    }
}
