//
//  PersisteceManager.swift
//  Starter Project
//
//  Created by Mohamed Atallah on 29/03/2023.
//

import Foundation


enum PersistenceActionType {
    case add, remove
}


enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Key {
        static let favorites = "favorites"
    }
    
    
    static func updateWith(favorite: Photo, actionType: PersistenceActionType, completion: @escaping (Error?) -> Void) {
        retrieveFavorites { result in
            switch result {
                
            case .success(let favPhotos):
                var retrievedPhotos = favPhotos
                
                switch actionType {
                case .add:
                    guard !retrievedPhotos.contains(favorite) else { return }
                    retrievedPhotos.insert(favorite, at: 0)
                case .remove:
                    retrievedPhotos.removeAll { $0.id == favorite.id }
                }
                
                completion(save(favorites: retrievedPhotos))
                
            case .failure(let error):
                completion(error)
                
            }
        }
    }
    
    
    static func retrieveFavorites(completion: @escaping (Result<[Photo], Error>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Key.favorites) as? Data else {
            completion(.success([]))
            return
        }
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Photo].self, from: favoritesData)
            completion(.success(favorites))
        } catch { completion(.failure(error)) }
    }
    
    
    private static func save(favorites: [Photo]) -> Error? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Key.favorites)
            return nil
        } catch { return error }
    }
    
}
