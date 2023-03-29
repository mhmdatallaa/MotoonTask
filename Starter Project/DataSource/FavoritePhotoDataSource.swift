//
//  FavoritePhotoDataSource.swift
//  Starter Project
//
//  Created by Mohamed Atallah on 29/03/2023.
//

import UIKit


class FavoritePhotoDataSource: NSObject, UITableViewDataSource {
    
    var favoritePhotos = [Photo]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritePhotos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoriteCell
        let favPhoto = favoritePhotos[indexPath.row]
        cell.set(for: favPhoto)
        return cell
    }
    
}
