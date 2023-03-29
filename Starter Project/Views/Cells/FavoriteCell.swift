//
//  FavoriteCell.swift
//  Starter Project
//
//  Created by Mohamed Atallah on 29/03/2023.
//

import UIKit



class FavoriteCell: UITableViewCell {
    
    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet private weak var createdDateLabel: UILabel!
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
    
    func set(for photo: Photo) {
        PhotoStore.shared.fetchImage(for: photo.photoURL.regular) { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(image):
                self.photoImageView.image = image
                self.createdDateLabel.text = photo.createdAt.changeDateFormat(to: .MMMdyyy)
            case let .failure(error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    
}

