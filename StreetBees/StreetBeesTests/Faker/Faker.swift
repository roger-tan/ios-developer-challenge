//
//  ComicFaker.swift
//  StreetBeesTests
//
//  Created by Roger TAN on 22/07/2018.
//  Copyright © 2018 Roger TAN. All rights reserved.
//

import Foundation
@testable import StreetBees

struct Faker {

    // (todo) use a fakery data for all strings

    static var imageResource: ImageResource {
        return ImageResource(path: "https://www.google.co.uk", extension: "jpg")
    }
    
    static var comic: Comic {
        return Comic(id: 42, title: "Thanos is not dead yet", thumbnail: Faker.imageResource, images: [Faker.imageResource])
    }
    
}
