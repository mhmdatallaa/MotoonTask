//
//  PhotosVC.swift
//  Starter Project
//
//  Created by Mohamed Atallah on 29/03/2023.
//

import UIKit


class PhotosViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var indicator: UIActivityIndicatorView!
    
    
    
    // MARK: - Properties
    let photoDataSource = PhotoDataSource()
    var page = 1

    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUP()
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
    
    func createTwoColumnsLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                            heightDimension: .fractionalHeight(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
        
        let spacing = CGFloat(10)
        group.interItemSpacing = .fixed(spacing)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func setUP() {
        collectionView.delegate = self
        collectionView.dataSource = photoDataSource
        collectionView.collectionViewLayout = createTwoColumnsLayout()
        indicator.layer.cornerRadius = 15
        navigationController?.navigationBar.prefersLargeTitles = true
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

