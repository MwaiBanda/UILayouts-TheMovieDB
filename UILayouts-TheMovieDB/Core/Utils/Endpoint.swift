//
//  Endpoint.swift
//  UILayouts-TheMovieDB
//
//  Created by Mwai Banda on 8/25/22.
//

import Foundation

struct Endpoint {
    var key: String
    var path: String
    var method: HttpMethod = .get
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
        Endpoint(
            key: Constants.TRENDING,
            path: "/3/trending/all/day"
        )
    }
    
    static var upcoming: Self {
        Endpoint(
            key: Constants.UPCOMING,
            path: "/3/movie/upcoming",
            queryItems: [
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "page", value: "\(2)")
            ]
        )
    }
    
    static func featured(pageNumber: Int) -> Self {
        Endpoint(
            key: Constants.FEATURED,
            path: "/3/movie/popular",
            queryItems: [
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "page", value: "\(pageNumber)")
            ]
        )
    }
    
    static func topRated(pageNumber: Int) -> Self {
         Endpoint(
            key: Constants.TOP_RATED,
            path: "/3/movie/top_rated",
            queryItems: [
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "page", value: "\(pageNumber)")
            ]
        )
    }
    
    static func search(searchTerm: String, pageNumber: Int) -> Self {
        Endpoint(
            key: Constants.SEARCH,
            path: "/3/search/movie",
            queryItems: [
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "query", value: "\(searchTerm)".replacingOccurrences(of: " ", with: "+")),
                URLQueryItem(name: "page", value: "\(pageNumber)"),
                URLQueryItem(name: "include_adult", value: "false")
            ]
        )
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
     }
}
