//
//  TrendingViewModel.swift
//  UILayouts-TheMovieDB
//
//  Created by Mwai Banda on 8/25/22.
//

import Foundation
import RxSwift

class TrendingViewModel {
    var movieService: MovieService
    var movies = PublishSubject<[Movie]>()
    
    init(movieService: MovieService = MovieServiceImpl.shared) {
        self.movieService = movieService
    }
    
    func getTrendingMovies() {
        movieService.fetchTrending { res in
            switch res {
            case .success(let movies):
                self.movies.onNext(movies)
                self.movies.onCompleted()
                print("[FETCH-RESULT]: Success")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
