//
//  MarvelClient.swift
//  StreetBees
//
//  Created by Roger TAN on 21/07/2018.
//  Copyright © 2018 Roger TAN. All rights reserved.
//

import Foundation

protocol MarvelClientType {
    typealias ComicsCompletionHandler = (_ comics: [Comic]?, _ error: Error?) -> Void
    
    func fetchComics(onCompletion: @escaping ComicsCompletionHandler)
}

enum NetworkError: Error {
    case invalid
}

final class MarvelClient: MarvelClientType {
    
    func fetchComics(onCompletion: @escaping MarvelClientType.ComicsCompletionHandler) {

        URLSession.shared.dataTask(with: APIConfiguration.baseURL) { (data, response, error) in
            if let error = error {
                onCompletion(nil, error)
            } else if let data = data, let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let resource = try decoder.decode(GenericResource<Comic>.self, from: data)
                    onCompletion(resource.data.results, nil)
                } catch let error {
                    onCompletion(nil, error)
                }
            } else {
                onCompletion(nil, NetworkError.invalid)
            }
        }.resume()
    }
    
}
