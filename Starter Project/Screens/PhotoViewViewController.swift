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
    var isFavorited = false

    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicator.layer.cornerRadius = 15
        isFavorited = UserDefaults.standard.bool(forKey: "\(photo.id)")
        
        setImage(for: photo)
        configureFavoritedButton()
        
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
    
    private func configureFavoritedButton() {
        favoriteButton.image = isFavorited ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
    }
    
    
    
    // MARK: - Actions
    @IBAction private func AddToFavoritedButtonClicked(_ sender: UIBarButtonItem) {
        isFavorited.toggle()
        UserDefaults.standard.set(isFavorited, forKey: "\(photo.id)")
        
        if isFavorited {
            favoriteButton.image = UIImage(systemName: "heart.fill")
            PersistenceManager.updateWith(favorite: photo, actionType: .add) { [weak self] _ in
                guard let self else { return }
                self.showToast(message: "✅ Added to favorites"
                          , font: UIFont.systemFont(ofSize: 12))
            }
        } else {
            favoriteButton.image = UIImage(systemName: "heart")
            PersistenceManager.updateWith(favorite: photo, actionType: .remove) { [weak self] _ in
                guard let self else { return }
                self.showToast(message: "❌ Removed from favorites", font: UIFont.systemFont(ofSize: 12))
            }
        }
    }
    
}
