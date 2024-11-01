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
    private init() {}
    
     func getFollowers(userName: String, page: Int,  completion: @escaping(Result<[Follower], GFError>) -> Void) {
        let endpoint = baseUrl + "/users/\(userName)/followers?per_page=100&page=\(page)"
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let jsonData = try decoder.decode([Follower].self, from: data)
                completion(.success(jsonData))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
     
     func getUserInfo(userName: String,  completion: @escaping(Result<User, GFError>) -> Void) {
        let endpoint = baseUrl + "/users/\(userName)"
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                print(response)
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let jsonData = try decoder.decode(User.self, from: data)
                completion(.success(jsonData))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
}
