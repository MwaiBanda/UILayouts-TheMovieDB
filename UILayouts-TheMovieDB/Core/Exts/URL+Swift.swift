//
//  URL+Swift.swift
//  UILayouts-TheMovieDB
//
//  Created by Mwai Banda on 8/25/22.
//

import Foundation

extension URL {
    static func originalImage(path: String) -> URL {
        makeForEndpoint("original\(path)")
    }

    static func compressedImage(path: String) -> URL {
        makeForEndpoint("w500\(path)")
    }
}

private extension URL {
    static func makeForEndpoint(_ endpoint: String) -> URL {
        URL(string: "\(Constants.BASE_IMAGE_URL)/\(endpoint)")!
    }
}
