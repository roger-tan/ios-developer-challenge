//
//  GenericResource.swift
//  StreetBees
//
//  Created by Roger TAN on 21/07/2018.
//  Copyright © 2018 Roger TAN. All rights reserved.
//

import Foundation

struct GenericResource<T: Codable>: Codable {
    let data: ResultsResource<T>
}

struct ResultsResource<T: Codable>: Codable {
    let results: [T]
}
