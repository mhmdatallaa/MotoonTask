//
//  PhotosVC.swift
//  Starter Project
//
//  Created by Mohamed Atallah on 29/03/2023.
//

import UIKit


class PhotosViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = photoDataSource
        }
    }
    @IBOutlet private weak var indicator: UIActivityIndicatorView!
    
    
    // MARK: - Properties
    let photoDataSource = PhotoDataSource()
    var page = 1

    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicator.layer.cornerRadius = 15
        
        fetchPhotos()
    }
    
    
    // MARK: - Methods
    private func fetchPhotos() {
        indicator.startAnimating()
        PhotoStore.shared.fetchPhotos(page: "\(page)") { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(photos):
                self.indicator.stopAnimating()
                self.photoDataSource.photos.append(contentsOf: photos)
            case let .failure(error):
                debugPrint(error.localizedDescription)
            }
            self.collectionView.reloadData()
        }
    }
    
    
    // MARK: - Segue methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showImage":
            if let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first {
                let photo = photoDataSource.photos[selectedIndexPath.row]
                let destination = segue.destination as! PhotoViewViewController
                destination.photo = photo
            }
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }


    
}



// MARK: - Extensions
extension PhotosViewController: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > (contentHeight - height) {
            page += 1
            fetchPhotos()
        }
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let collectionWidth = collectionView.bounds.width
           return CGSize(width: (collectionWidth / 3) - 2, height: (collectionWidth / 3) - 2)
       }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 7.0
    }
}
