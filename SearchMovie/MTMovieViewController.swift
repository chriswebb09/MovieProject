//
//  MTMovieViewController.swift
//  MovieTumble
//
//  Created by Christopher Webb-Orenstein on 3/25/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MovieCell"

final class MTMovieViewController: UICollectionViewController {
    
    var movies: [MTMovie]!
    var selectedIndex: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.allowsMultipleSelection = true
        let nib = UINib(nibName: "MovieCell", bundle: nil)
        let font = UIFont(name: "Helvetica", size: 18)
        collectionView?.register(nib, forCellWithReuseIdentifier: "MovieCell")
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: font]
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCell
        cell.setup(hidden: true)
        cell.activityIndicator.startAnimating()
        MTAPIClient.downloadImage(url: movies[indexPath.row].posterImageURL) { image in
            if let posterImage = image {
                DispatchQueue.main.async {
                    cell.configureCell(title: self.movies[indexPath.row].title, poster: posterImage)
                }
            }
        }
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        if let selected = selectedIndex {
            if let selectedCell = collectionView.cellForItem(at: selected) as? MovieCell {
                selectedCell.isSelected = !selectedCell.isSelected
                selectedCell.setStyle(selected: selectedCell.isSelected)
                selectedIndex = nil
            }
        }
        if let cell = collectionView.cellForItem(at: indexPath) as? MovieCell {
            selectedIndex = indexPath
            cell.isSelected = true
            cell.setStyle(selected: cell.isSelected)
        }
        return true
    }
}
