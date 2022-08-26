//
//  Endpoint.swift
//  UILayouts-TheMovieDB
//
//  Created by Mwai Banda on 8/25/22.
//

import Foundation

struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = Constants.SCHEME
        components.host = Constants.HOST
        components.path = path
        components.queryItems = [URLQueryItem(name: "api_key", value: Constants.API_KEY)]
        if !queryItems.isEmpty {
            components.queryItems?.append(contentsOf: queryItems)
        }
        
        guard let url = components.url else {
            preconditionFailure(
                "Invalid URL components: \(components)"
            )
        }

        return url
    }
}

extension Endpoint {
    static var trending: Self {
        Endpoint(path: "/3/trending/all/day")
    }
}
