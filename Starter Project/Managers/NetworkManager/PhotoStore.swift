//
//  PhotoStore.swift
//  Starter Project
//
//  Created by Mohamed Atallah on 29/03/2023.
//

import UIKit


enum PhotoError: Error {
    case imageCreationError
}


class PhotoStore {
    
    static let shared = PhotoStore()
    let cache = NSCache<NSString, UIImage>()
    var cacheKey: NSString!
    
    private init() { }
    
    
    func fetchPhotos(page: String, completion: @escaping (Result<[Photo], Error>) -> Void) {
        var url = UnsplashAPI.photoURL
        url.append(queryItems: [URLQueryItem(name: "page", value: page)])
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self else { return }
            let result = self.processPhotosRequest(data: data, error: error)
            OperationQueue.main.addOperation { completion(result) }
        }
        task.resume()
    }
    
    
    private func processPhotosRequest(data: Data?, error: Error?) -> Result<[Photo], Error> {
        guard let jsonData = data else { return .failure(error!)}
        return UnsplashAPI.photos(fromJson: jsonData)
    }
    
    
    func fetchImage(for urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completion(.success(image))
            return
        }
        
        guard let photoURL = URL(string: urlString) else { return }
        
        let request = URLRequest(url: photoURL)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self else { return }
            let result = self.processImageRequest(data: data, error: error)
            OperationQueue.main.addOperation { completion(result) }
        }
        task.resume()
    }
    
    
    private func processImageRequest(data: Data?, error: Error?) -> Result<UIImage, Error> {
        guard let imageData = data,
              let image = UIImage(data: imageData) else {
            if data == nil { return .failure(error!)}
            else { return .failure(PhotoError.imageCreationError)}
        }
        cache.setObject(image, forKey: cacheKey)
        return .success(image
        )
    }
    
}
