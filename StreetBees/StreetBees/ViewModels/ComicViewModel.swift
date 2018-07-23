//
//  ComicViewModel.swift
//  StreetBees
//
//  Created by Roger TAN on 21/07/2018.
//  Copyright © 2018 Roger TAN. All rights reserved.
//

import Foundation

struct ComicViewModel {
    
    let model: Comic
    
    var thumbnail: URL? {
        return URL(string: model.thumbnail.path)?.appendingPathComponent("portrait_medium").appendingPathExtension(model.thumbnail.extension)
    }
    
    var image: URL? {
        guard let urlRaw = model.images.first?.path, let url = URL(string: urlRaw), let ext = model.images.first?.extension else {
            return nil
        }
        return url.appendingPathComponent("portrait_uncanny").appendingPathExtension(ext)
    }
    
}

extension ComicViewModel: Equatable {
    static func == (lhs: ComicViewModel, rhs: ComicViewModel) -> Bool {
        return lhs.model == rhs.model
    }
    
}
