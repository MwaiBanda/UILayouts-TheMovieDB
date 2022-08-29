//
//  MovieService.swift
//  UILayouts-TheMovieDB
//
//  Created by Mwai Banda on 8/25/22.
//

import Foundation


protocol MovieService {
    func fetchTrending(onCompletion: @escaping (Result<[Movie], Error>) -> Void)
    func fetchUpcoming(onCompletion: @escaping (Result<[Movie], Error>) -> Void)
    func fetchFeatured(pageNumber: Int, onCompletion: @escaping (Result<[Movie], Error>) -> Void)
    func fetchTopRated(pageNumber: Int, onCompletion: @escaping (Result<[Movie], Error>) -> Void)

}
