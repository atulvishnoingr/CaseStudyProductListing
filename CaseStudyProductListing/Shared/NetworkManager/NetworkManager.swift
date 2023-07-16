//
//  NetworkManager.swift
//  CaseStudyProductListing
//
//  Created by Atul Vishnoi on 13/07/23.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case invalidData
}

enum FeedType: String {
    case emailed
    case shared
    case viewed
}

struct NetworkManager {
    // Base API URL
    private let baseUrl = "https://api.nytimes.com/svc/mostpopular/v2/"
    // API Key
    private let apiKey = "RAkAhPXo0kaO0yqbS8W6ZfshjhjvZft8"

    typealias FeedCompletionClosure = ((ArticlesResponse?, Error?) -> Void)

    private func createRequest(for url: String) -> URLRequest? {
        guard let url = URL(string: url) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        return request
    }

    private func executeRequest<T: Codable>(request: URLRequest, completion: ((T?, Error?) -> Void)?) {
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request) { (data, _, error) in
            guard let data = data else {
                completion?(nil, error)
                return
            }
            if let decodedResponse = try? JSONDecoder().decode(T.self, from: data) {
                DispatchQueue.main.async {
                    completion?(decodedResponse, nil)
                }
            } else {
                completion?(nil, NetworkError.invalidData)
            }
        }
        dataTask.resume()
    }

    func fetchEmailedArticles(completion: FeedCompletionClosure?) {
        let url = baseUrl + FeedType.emailed.rawValue + "/1.json?api-key=\(apiKey)"
        guard let request = createRequest(for: url) else {
            completion?(nil, NetworkError.invalidUrl)
            return
        }
        executeRequest(request: request, completion: completion)
    }

    func fetchSharedArticles(completion: FeedCompletionClosure?) {
        let url = baseUrl + FeedType.shared.rawValue + "/1.json?api-key=\(apiKey)"
        guard let request = createRequest(for: url) else {
            completion?(nil, NetworkError.invalidUrl)
            return
        }
        executeRequest(request: request, completion: completion)
    }

    func fetchViewedArticles(completion: FeedCompletionClosure?) {
        let url = baseUrl + FeedType.viewed.rawValue + "/1.json?api-key=\(apiKey)"
        guard let request = createRequest(for: url) else {
            completion?(nil, NetworkError.invalidUrl)
            return
        }
        executeRequest(request: request, completion: completion)
    }
}
