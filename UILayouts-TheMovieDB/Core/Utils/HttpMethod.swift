//
//  HttpMethod.swift
//  UILayouts-TheMovieDB
//
//  Created by Mwai Banda on 8/28/22.
//

import Foundation

enum HttpMethod {
    case get
    case post(Data?)
    
    var name: String {
        switch self {
            case .get:
                return "GET"
            case .post:
                return "POST"
        }
    }
}
