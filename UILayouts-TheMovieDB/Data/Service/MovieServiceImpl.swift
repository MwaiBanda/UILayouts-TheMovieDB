//
//  MovieServiceImpl.swift
//  UILayouts-TheMovieDB
//
//  Created by Mwai Banda on 8/25/22.
//

import Foundation



class MovieServiceImpl: MovieService {
  
    private var requestProcessor: RequestProcessor
    
    init(requestProcessor: RequestProcessor = RemoteRequestProcessor()) {
        self.requestProcessor = requestProcessor
    }
    
    func fetchFeatured(pageNumber: Int, onCompletion: @escaping (Result<[Movie], Error>) -> Void) {
        requestProcessor.request(MoviesDTO.self, endpoint: Endpoint.featured(pageNumber: pageNumber)) { result in
            switch result {
            case .success(let movieResponse):
                onCompletion(.success(
                    movieResponse.collection.map({ $0.toMovie() })
                        .filter({ !$0.title.isEmpty })
                ))
            case .failure(let error):
                onCompletion(.failure(error))
            }
        }
    }
    
    func fetchUpcoming(onCompletion: @escaping (Result<[Movie], Error>) -> Void) {
        requestProcessor.request(MoviesDTO.self, endpoint: Endpoint.upcoming) { result in
            switch result {
            case .success(let movieResponse):
                onCompletion(.success(
                    movieResponse.collection.map({ $0.toMovie() })
                        .filter({ !$0.title.isEmpty })
                ))
            case .failure(let error):
                onCompletion(.failure(error))
            }
        }
    }
    
    func fetchTrending(onCompletion: @escaping (Result<[Movie], Error>) -> Void) {
        requestProcessor.request(MoviesDTO.self, endpoint: Endpoint.trending) { result in
            switch result {
            case .success(let movieResponse):
                onCompletion(.success(
                    movieResponse.collection.map({ $0.toMovie() })
                        .filter({ !$0.title.isEmpty })
                ))
            case .failure(let error):
                onCompletion(.failure(error))
            }
        }
    }
    
    func fetchTopRated(pageNumber: Int, onCompletion: @escaping (Result<[Movie], Error>) -> Void) {
        requestProcessor.request(MoviesDTO.self, endpoint: Endpoint.topRated(pageNumber: pageNumber)) { result in
            switch result {
            case .success(let movieResponse):
                onCompletion(.success(
                    movieResponse.collection.map({ $0.toMovie() })
                        .filter({ !$0.title.isEmpty })
                ))
            case .failure(let error):
                onCompletion(.failure(error))
            }
        }
    }
}

extension MovieServiceImpl {
    static let shared = MovieServiceImpl()
}
