//
//  PhotoViewVC.swift
//  Starter Project
//
//  Created by Mohamed Atallah on 29/03/2023.
//

import UIKit


class PhotoViewViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var indicator: UIActivityIndicatorView!
    @IBOutlet private weak var favoriteButton: UIBarButtonItem!


    // MARK: - Properties
    var photo: Photo!

    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicator.layer.cornerRadius = 15
        
        setImage(for: photo)
        
    }
    
    
    // MARK: - Methods
    private func setImage(for photo: Photo) {
        indicator.startAnimating()
        PhotoStore.shared.fetchImage(for: photo.photoURL.full) { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(image):
                self.indicator.stopAnimating()
                self.imageView.image = image
            case let .failure(error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    
    // MARK: - Actions
    @IBAction private func AddToFavoritedButtonClicked(_ sender: UIBarButtonItem) {
        
    }

    
}



// MARK: - Extensions
