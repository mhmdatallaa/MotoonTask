//
//  UsplashAPI.swift
//  Starter Project
//
//  Created by Mohamed Atallah on 29/03/2023.
//

import Foundation


enum EndPoint: String {
    case photos = "/photos"
}


struct UnsplashAPI {
    
    private static let baseURLString = "https://api.unsplash.com"
    private static let clinetID = "Ahj-66mbyiRNL-GhTltHoIgGfkznNgv7SALhCOTLMaM"
    
    static var photoURL: URL {
        return unsplashURL(endPoint: .photos, parameters: ["per_page": "30"])
    }
    
    
    private static func unsplashURL(endPoint: EndPoint, parameters: [String: String]?) -> URL {
        let urlString = baseURLString + endPoint.rawValue
        
        var components = URLComponents(string: urlString)!
        var queryItems = [URLQueryItem]()
        
        let baseQueryParameter = URLQueryItem(name: "client_id", value: clinetID)
        queryItems.append(baseQueryParameter)
        
        if let parameters {
            for (key, value) in parameters {
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }

        components.queryItems = queryItems
        return components.url!
    }
    
    
    static func photos(fromJson data: Data) -> Result<[Photo], Error> {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let photos = try decoder.decode([Photo].self, from: data)
            return .success(photos)
        } catch {
            return .failure(error)
        }
    }
    
}

