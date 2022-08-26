//
//  TrendingViewModel.swift
//  UILayouts-TheMovieDB
//
//  Created by Mwai Banda on 8/25/22.
//

import Foundation

class TrendingViewModel {
    var movieService: MovieService
    
    init(movieService: MovieService = MovieServiceImpl.shared) {
        self.movieService = movieService
    }
    
    func getTrendingMovies() {
        movieService.fetchTrending { res in
            switch res {
            case .success(let movies):
                print(movies)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
