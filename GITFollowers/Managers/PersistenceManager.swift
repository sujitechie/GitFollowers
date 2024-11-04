//
//  PersistenceManager.swift
//  GITFollowers
//
//  Created by sujith on 04/11/24.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    
    enum Keys {
         static let favourites = "favourites"
    }
    
    private static let defaults = UserDefaults.standard
    
    
    static func updateWith(favourite: Follower, actionType: PersistenceActionType, completed: @escaping(GFError?) -> Void)
    {
        retrieveFavourites { result in
            switch result {
            case .success(let favourites):
                var retrievedFavourites = favourites
                
                switch actionType {
                case .add:
                    guard !retrievedFavourites.contains(favourite) else {
                        completed(GFError.alreadyFavourited)
                        return
                    }
                    retrievedFavourites.append(favourite)
                    
                case .remove:
                    retrievedFavourites.removeAll { follower in
                        return follower.login == favourite.login
                    }
                }
                completed(save(favourites: retrievedFavourites))
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    static func retrieveFavourites(completed: @escaping(Result<[Follower], GFError>) -> Void ) {
        
        guard let favouritesData = defaults.object(forKey: Keys.favourites) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favourites = try decoder.decode([Follower].self, from: favouritesData)
            completed(.success(favourites))
        } catch {
            completed(.failure(GFError.unableToFavourite))
        }
        
    }
    
    static func save(favourites: [Follower]) -> GFError? {
        do {
            let encoder = JSONEncoder()
            let favouritesData = try encoder.encode(favourites)
            defaults.set(favouritesData, forKey: Keys.favourites)
            return nil
        } catch {
            return GFError.unableToFavourite
        }
    }
}
