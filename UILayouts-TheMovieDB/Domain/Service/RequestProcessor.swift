//
//  RequestProcessor.swift
//  UILayouts-TheMovieDB
//
//  Created by Mwai Banda on 8/27/22.
//

import Foundation

protocol RequestProcessor {
    func request<T>(
        _ type: T.Type,
        url: URL,
        onCompletion: @escaping (Result<T, Error>) -> Void
    ) where T: Codable
}
