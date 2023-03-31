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
    @IBOutlet private weak var indicator: UIActivityIndicatorView! {
        didSet {
            indicator.layer.cornerRadius = 10
        }
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
    
    func set(for photo: Photo) {
        indicator.startAnimating()
        PhotoStore.shared.fetchImage(for: photo.url.regular) { [weak self] result in
            guard let self else { return }
            self.indicator.stopAnimating()
            switch result {
            case let .success(image):
                self.photoImageView.layer.cornerRadius = 20
                self.photoImageView.image = image
                self.createdDateLabel.text = "Created at: \(photo.createdAt.changeDateFormat(to: .MMMdyyy))"
            case let .failure(error):
                debugPrint(error.localizedDescription)
            }
        }
    }

}

