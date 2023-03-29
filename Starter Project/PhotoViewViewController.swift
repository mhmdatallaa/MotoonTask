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

    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    // MARK: - Actions
    @IBAction private func AddToFavoritedButtonClicked(_ sender: UIBarButtonItem) {
        
    }

    
}



// MARK: - Extensions
