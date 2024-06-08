//
//  NetworkClient.swift
//  ImageFeed
//
//  Created by Рина Райф on 07.06.2024.
//

import Foundation

//MARK: - NetworkError
enum NetworkError: Error {
    case httpStatusCode(Int)
    case urlRequestError(Error)
    case urlSessionError
}

//MARK: - URLSession
extension URLSession {
    func data(
        for request: URLRequest,
        completion: @escaping (Result<Data, Error>) -> Void
    ) -> URLSessionTask {
        let fulfillCompletionOnTheMainThread: (Result<Data, Error>) -> Void = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        let task = dataTask(with: request, completionHandler: { data, response, error in // Задача выполняющая HTTP запрос
            if let data = data, let response = response, let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if 200 ..< 300 ~= statusCode {
                    fulfillCompletionOnTheMainThread(.success(data)) // Вызывает замыкание с успешным результатом
                } else {
                    fulfillCompletionOnTheMainThread(.failure(NetworkError.httpStatusCode(statusCode))) // Вызывает замыкание с ошибкой
                    print("HTTP Error: \(String(describing: error))")
                }
            } else if let error = error { // Блок для обработки ошибок
                fulfillCompletionOnTheMainThread(.failure(NetworkError.urlRequestError(error))) // Ошибка передается в замыкание fulfillCompletionOnTheMainThread
                print("URLRequest Error: \(error)")
            } else {
                fulfillCompletionOnTheMainThread(.failure(NetworkError.urlSessionError)) // При неизвестной ошибки
                print("URLSession Error")
            }
        })
        
        return task
    }
}
