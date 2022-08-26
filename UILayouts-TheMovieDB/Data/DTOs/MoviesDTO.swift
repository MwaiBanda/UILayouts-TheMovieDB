//
//  MoviesDTO.swift
//  UILayouts-TheMovieDB
//
//  Created by Mwai Banda on 8/25/22.
//

import Foundation


// MARK: - MoviesDTO
struct MoviesDTO: Codable {
    let page: Int
    let collection: [MovieDTO]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case collection = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
