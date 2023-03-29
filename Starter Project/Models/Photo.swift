//
//  Photo.swift
//  Starter Project
//
//  Created by Mohamed Atallah on 29/03/2023.
//

import Foundation


struct Photo: Codable, Hashable {
    let id: String
    let createdAt: Date
    let photoURL: PhotoURL
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case photoURL = "urls"
    }
}


struct PhotoURL: Codable, Hashable {
    let full: String
    let regular: String
    let thumb: String
}
