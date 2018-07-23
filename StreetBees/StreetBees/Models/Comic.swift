//
//  Comic.swift
//  StreetBees
//
//  Created by Roger TAN on 21/07/2018.
//  Copyright © 2018 Roger TAN. All rights reserved.
//

import Foundation

struct Comic: Codable {
    let id: Int
    let title: String
    let thumbnail: ImageResource
    let images: [ImageResource]
}

extension Comic: Equatable {
    static func == (lhs: Comic, rhs: Comic) -> Bool {
        return lhs.id == rhs.id
    }
}
