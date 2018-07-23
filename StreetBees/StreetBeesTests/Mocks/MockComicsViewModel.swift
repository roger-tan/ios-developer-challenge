//
//  MockComicsViewModel.swift
//  StreetBeesTests
//
//  Created by Roger TAN on 22/07/2018.
//  Copyright © 2018 Roger TAN. All rights reserved.
//

import Foundation
@testable import StreetBees

final class MockComicsViewModel: ComicsViewModelType, ComicsViewModelInputs, ComicsViewModelOutputs {
    
    // MARK: - ComicsViewModelType
    
    var inputs: ComicsViewModelInputs { return self }
    
    var outputs: ComicsViewModelOutputs { return self }
    
    var reloadData: (() -> Void)?
    var showComicDetail: ((ComicViewModel) -> Void)?
    
    // MARK: - ComicsViewModelInputType
    
    func viewDidLoad() {
        viewDidLoadCalled = true
    }

    func select(at index: Int) {
        guard let comic = outputs.comic(at: index) else {
            return
        }
        showComicDetail?(comic)
    }
    

    // MARK: - ComicsViewModelOutputType
    
    func numberOfRows() -> Int {
        return comics.count
    }
    
    func comic(at index: Int) -> ComicViewModel? {
        return comics[index]
    }
    
    // MARK : - Stored Properties
    
    var comics = [ComicViewModel]()
    var viewDidLoadCalled = false
    
}
