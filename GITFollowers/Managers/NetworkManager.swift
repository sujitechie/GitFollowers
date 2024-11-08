//
//  NetworkManager.swift
//  GITFollowers
//
//  Created by sujith on 27/09/24.
//

import UIKit


class NetworkManager {
    
    
    static let shared = NetworkManager()
    private let baseUrl = "https://api.github.com"
    let cache = NSCache<NSString, UIImage>()
    let decoder = JSONDecoder()
    
    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
    }
    
    func getFollowers(userName: String, page: Int) async throws -> [Follower] {
        
        let endpoint = baseUrl + "/users/\(userName)/followers?per_page=100&page=\(page)"
        guard let url = URL(string: endpoint) else {
            throw GFError.invalidUsername
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GFError.invalidResponse
        }
        
        do {
            
            return try decoder.decode([Follower].self, from: data)
            
        } catch {
            throw GFError.invalidData
        }
    }
    
    func getUserInfo(userName: String) async throws  -> User {
        let endpoint = baseUrl + "/users/\(userName)"
        guard let url = URL(string: endpoint) else {
            throw GFError.invalidUsername
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GFError.invalidResponse
        }
    
        do {
            return try decoder.decode(User.self, from: data)
        } catch {
            throw GFError.invalidData
        }
        
    }
    
    func downloadImage(from urlString: String , completion: @escaping(UIImage?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            completion(image)
            return
        }
        
        let downloadTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data)
            else {
                completion(nil)
                return
            }
            self.cache.setObject(image, forKey: cacheKey)
            completion(image)
        }
        downloadTask.resume()
    }
    
    //  Network call using completion handler
    
    //    func getUserInfo(userName: String,  completion: @escaping(Result<User, GFError>) -> Void) {
    //        let endpoint = baseUrl + "/users/\(userName)"
    //        guard let url = URL(string: endpoint) else {
    //            completion(.failure(.invalidUsername))
    //            return
    //        }
    //
    //        let task = URLSession.shared.dataTask(with: url) { [self] data, response, error in
    //            if let _ = error {
    //                completion(.failure(.unableToComplete))
    //                return
    //            }
    //
    //            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
    //                completion(.failure(.invalidResponse))
    //                return
    //            }
    //
    //            guard let data = data else {
    //                completion(.failure(.invalidData))
    //                return
    //            }
    //
    //
    //            do {
    //                let jsonData = try decoder.decode(User.self, from: data)
    //                completion(.success(jsonData))
    //            } catch {
    //                completion(.failure(.invalidData))
    //            }
    //        }
    //
    //        task.resume()
    //    }
    
    
    // Network call using completion handler
    
    //     func getFollowers(userName: String, page: Int,  completion: @escaping(Result<[Follower], GFError>) -> Void) {
    //        let endpoint = baseUrl + "/users/\(userName)/followers?per_page=100&page=\(page)"
    //        guard let url = URL(string: endpoint) else {
    //            completion(.failure(.invalidUsername))
    //            return
    //        }
    //
    //        let task = URLSession.shared.dataTask(with: url) { data, response, error in
    //            if let _ = error {
    //                completion(.failure(.unableToComplete))
    //                return
    //            }
    //
    //            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
    //                completion(.failure(.invalidResponse))
    //                return
    //            }
    //
    //            guard let data = data else {
    //                completion(.failure(.invalidData))
    //                return
    //            }
    //
    //
    //            do {
    //                let decoder = JSONDecoder()
    //                decoder.keyDecodingStrategy = .convertFromSnakeCase
    //                let jsonData = try decoder.decode([Follower].self, from: data)
    //                completion(.success(jsonData))
    //            } catch {
    //                completion(.failure(.invalidData))
    //            }
    //        }
    //
    //        task.resume()
    //    }
}
