//
//  BrowseViewModel.swift
//  UILayouts-TheMovieDB
//
//  Created by Mwai Banda on 8/28/22.
//

import Foundation
import RxSwift
import RxRelay

class BrowseViewModel {
    var movieService: MovieService
    var movies = BehaviorRelay<[[Movie]]>(value: [[Movie]]())
    
    init(movieService: MovieService = MovieServiceImpl.shared) {
        self.movieService = movieService
    }
    
    func getMovies(){
        getTrendingMovies { [unowned self] trending in
            self.movies.accept(trending)
            getFeaturedMovies { featured in
                self.movies.accept(featured)
            }
        }
    }
    func getFeaturedMovies(onCompletion: @escaping ([[Movie]]) -> Void) {
        movieService.fetchFeatured { res in
            switch res {
            case .success(let movies):
                onCompletion(self.movies.value + [movies])
                print("[FETCH-RESULT]: Success")
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getTrendingMovies(onCompletion: @escaping ([[Movie]]) -> Void) {
        self.movieService.fetchTrending { res in
            switch res {
            case .success(let movies):
                onCompletion(self.movies.value + [movies])
                print("[FETCH-RESULT]: Success")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
