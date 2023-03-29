//
//  FavoritesViewController.swift
//  Starter Project
//
//  Created by Mohamed Atallah on 29/03/2023.
//

import UIKit



class FavoritesViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var emptyState: UILabel!
    
    
    
    // MARK: - Properties
    let favPhotosDataSource = FavoritePhotoDataSource()
    var isHiddenEmptyState = true
    
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 500
        tableView.dataSource = favPhotosDataSource
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getFavorites()
        emptyState.text = isHiddenEmptyState ? "" : "No favorite images yet! 😶"
    }
    
    
    
    // MARK: - Methods
    private func getFavorites() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self else { return }
            switch result {
            case.success(let favPhotos):
                if favPhotos.isEmpty {
                    self.isHiddenEmptyState = false
                    self.favPhotosDataSource.favoritePhotos = []
                } else {
                    self.isHiddenEmptyState = true
                    self.favPhotosDataSource.favoritePhotos = favPhotos
                }
                self.tableView.reloadData()
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    
    
    // MARK: - Segue methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showFavoriteImage":
            if let selectedIndex = tableView.indexPathsForSelectedRows?.first {
                let photo = favPhotosDataSource.favoritePhotos[selectedIndex.row]
                let destination = segue.destination as! PhotoViewViewController
                destination.photo = photo
            }
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
    
}



// MARK: - Extensions
extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

