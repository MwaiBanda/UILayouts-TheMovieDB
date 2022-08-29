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
            getFeaturedMovies { [unowned self] featured in
                getTopRatedMovies { [unowned self] topRated in
                    getUpcomingMovies { [unowned self] latest in
                        movies.accept(latest + trending + topRated + featured)
                    }
                }
            }
        }
    }
    func getFeaturedMovies(onCompletion: @escaping ([[Movie]]) -> Void) {
        movieService.fetchFeatured(pageNumber: 1) { res in
            switch res {
            case .success(let movies):
                onCompletion(self.movies.value + [movies])
                print("[FETCH-RESULT]: Success")
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func getUpcomingMovies(onCompletion: @escaping ([[Movie]]) -> Void) {
        movieService.fetchUpcoming { res in
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
    
    func getTopRatedMovies(onCompletion: @escaping ([[Movie]]) -> Void) {
        self.movieService.fetchTopRated(pageNumber: 1) { res in
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
