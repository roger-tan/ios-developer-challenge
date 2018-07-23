//
//  APIConfiguration.swift
//  StreetBees
//
//  Created by Roger TAN on 21/07/2018.
//  Copyright © 2018 Roger TAN. All rights reserved.
//

import Foundation

final class APIConfiguration {

    static let baseURL: URL = {
        // For UI Test Mock
        if CommandLine.arguments.contains("uitest"), let uiBaseURL = URL(string: "https://www.mocky.io/v2/5b5479f62f00004f000619a6") {
            return uiBaseURL
        }
        
        guard let baseURL = URL(string: "https://gateway.marvel.com/v1/public/comics?apikey=b84be880c3213c397e805cb7bead38e4&hash=dd8de91045f8b9d63208d5ed5bfc9b6a&ts=1532198696") else {
            assertionFailure("Invalid Base URL")
            return URL(fileURLWithPath: NSTemporaryDirectory())
        }
        
        return baseURL
    }()
    
}
