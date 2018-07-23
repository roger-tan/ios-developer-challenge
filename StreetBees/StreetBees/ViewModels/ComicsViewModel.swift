//
//  ComicsViewModel.swift
//  StreetBees
//
//  Created by Roger TAN on 21/07/2018.
//  Copyright © 2018 Roger TAN. All rights reserved.
//

import Foundation

protocol ComicsViewModelInputs {
    func viewDidLoad()
    func select(at index: Int)
}

protocol ComicsViewModelOutputs {
    func numberOfRows() -> Int
    func comic(at Index: Int) -> ComicViewModel?
}

protocol ComicsViewModelType {
    var inputs: ComicsViewModelInputs { get }
    var outputs: ComicsViewModelOutputs { get }
    // SHould be in output when I can't do in non rx style
    var reloadData: (() -> Void)? { get set }
    var showComicDetail: ((ComicViewModel) -> Void)? { get set }
}

final class ComicsViewModel: ComicsViewModelInputs, ComicsViewModelOutputs, ComicsViewModelType {
    
    init(client: MarvelClientType = MarvelClient()) {
        self.client = client
    }
    
    // MARK: Stored Properties
    
    private var comics: [ComicViewModel] = []
    private var client: MarvelClientType
    
    // MARK: - ComicsViewModelInputType
    
    func viewDidLoad() {
        client.fetchComics(onCompletion: { [unowned self] (comics, error) in
            guard error == nil else {
                return
            }
            self.comics = comics?.compactMap(ComicViewModel.init) ?? []
            self.reloadData?()
        })
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
        guard 0 ... comics.count ~= index else {
            return nil
        }
        return comics[index]
    }
    
    // MARK: - ComicsViewModelType
    
    var inputs: ComicsViewModelInputs { return self }
    var outputs: ComicsViewModelOutputs { return self }
    var reloadData: (() -> Void)?
    var showComicDetail: ((ComicViewModel) -> Void)?

}
