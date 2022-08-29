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
        endpoint: Endpoint,
        onCompletion: @escaping (Result<T, Error>) -> Void
    ) where T: Codable {
        
        var request = URLRequest(url: endpoint.url)
        
        switch endpoint.method {
        case .get: break
        case .post(let data):
            request.httpMethod = endpoint.method.name
            request.httpBody = data
        }
        
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Content-Type": "application/json"]
        let session = URLSession(configuration: configuration)
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                onCompletion(.failure(error))
            } else {
                if let data = data, let response = response as? HTTPURLResponse {
                    if response.statusCode == 200 {
                        do {
                            let responseData = try JSONDecoder().decode(T.self, from: data)
                            onCompletion(.success(responseData))
                        } catch DecodingError.dataCorrupted(let context) {
                            print(context)
                            onCompletion(.failure(DecodingError.dataCorrupted(context)))
                        } catch DecodingError.keyNotFound(let key, let context) {
                            print("Key '\(key)' not found:", context.debugDescription)
                            print("codingPath:", context.codingPath)
                            onCompletion(.failure(DecodingError.keyNotFound(key, context)))
                        } catch DecodingError.valueNotFound(let value, let context) {
                            print("Value '\(value)' not found:", context.debugDescription)
                            print("codingPath:", context.codingPath)
                            onCompletion(.failure(DecodingError.valueNotFound(value, context)))
                        } catch DecodingError.typeMismatch(let type, let context) {
                            print("Type '\(type)' mismatch:", context.debugDescription)
                            print("codingPath:", context.codingPath)
                            onCompletion(.failure(DecodingError.typeMismatch(type, context)))
                        } catch {
                            print("error: ", error)
                            onCompletion(.failure(error))
                        }
                    }
                }
            }
        }
        task.resume()
    }
}
