//
//  SearchViewModel.swift
//  UILayouts-TheMovieDB
//
//  Created by Mwai Banda on 8/29/22.
//

import Foundation
import RxRelay

class SearchViewModel {
    var movieService: MovieService
    var movies = BehaviorRelay<[Movie]>(value: [Movie]())
    
    init(movieService: MovieService = MovieServiceImpl.shared) {
        self.movieService = movieService
    
    }
    
    func search(searchTerm: String) {
        let filtered = movies.value.filter({ $0.title.contains(searchTerm.capitalized) || $0.title.contains(searchTerm) })
        movies.accept([])
        if filtered.isEmpty {
            movieService.fetchSearch(searchTerm: searchTerm.capitalized, pageNumber: 1) { res in
                switch res {
                case .success(let movies):
                    let filtered = movies.filter({  $0.title.contains(searchTerm.capitalized) || $0.title.contains(searchTerm) })
                    self.movies.accept(filtered)
                    print("[FETCH-RESULT]: Success")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        } else {
            self.movies.accept(filtered)
        }
    }
}
