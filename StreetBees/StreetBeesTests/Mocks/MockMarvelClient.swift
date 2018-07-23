//
//  MockMarvelClient.swift
//  StreetBeesTests
//
//  Created by Roger TAN on 22/07/2018.
//  Copyright © 2018 Roger TAN. All rights reserved.
//

import Foundation
@testable import StreetBees

final class MockMarvelClient: MarvelClientType {

    func fetchComics(onCompletion: @escaping MarvelClientType.ComicsCompletionHandler) {
        fetchComics?(onCompletion)
    }

    // MARK: - Stored Properties
    
    var fetchComics: ((MarvelClientType.ComicsCompletionHandler) -> Void)?

}
