//
//  RemoteRequestProcessor.swift
//  UILayouts-TheMovieDB
//
//  Created by Mwai Banda on 8/27/22.
//

import Foundation

class RemoteRequestProcessor: RequestProcessor {
    func request<T>(
        _ type: T.Type,
        url: URL,
        onCompletion: @escaping (Result<T, Error>) -> Void
    ) where T: Codable {
        
        let task = URLSession
            .shared
            .dataTask(
                with: url
            ) { data, response, error in
                if let error = error {
                    onCompletion(.failure(error))
                } else {
                    if let data = data, let response = response as? HTTPURLResponse {
                        if response.statusCode == 200 {
                            do {
                                let movieResponse = try JSONDecoder().decode(T.self, from: data)
                                onCompletion(.success(movieResponse))
                            } catch DecodingError.dataCorrupted(let context) {
                                print(context)
                            } catch DecodingError.keyNotFound(let key, let context) {
                                print("Key '\(key)' not found:", context.debugDescription)
                                print("codingPath:", context.codingPath)
                            } catch DecodingError.valueNotFound(let value, let context) {
                                print("Value '\(value)' not found:", context.debugDescription)
                                print("codingPath:", context.codingPath)
                            } catch DecodingError.typeMismatch(let type, let context) {
                                print("Type '\(type)' mismatch:", context.debugDescription)
                                print("codingPath:", context.codingPath)
                            } catch {
                                print("error: ", error)
                            }
                        }
                    }
                }
            }
        task.resume()
    }
}
