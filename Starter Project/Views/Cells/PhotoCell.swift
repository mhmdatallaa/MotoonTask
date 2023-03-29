//
//  PhotoCell.swift
//  Starter Project
//
//  Created by Mohamed Atallah on 29/03/2023.
//

import UIKit


class PhotoCell: UICollectionViewCell {
    
    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet private weak var createdDate: UILabel!
    @IBOutlet private weak var indicator: UIActivityIndicatorView!
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
    
    func set(for photo: Photo) {
        indicator.startAnimating()
        PhotoStore.shared.fetchImage(for: photo.photoURL.thumb) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(image):
                self.indicator.stopAnimating()
                self.photoImageView.image = image
                self.photoImageView.layer.cornerRadius = 10
                self.createdDate.text = photo.createdAt.changeDateFormat(to: .MMMdyyy)
            case let .failure(error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    
}
