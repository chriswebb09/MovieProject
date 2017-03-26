//
//  MTMovieViewController.swift
//  MovieTumble
//
//  Created by Christopher Webb-Orenstein on 3/25/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MovieCell"

class MTMovieViewController: UICollectionViewController {
    
    var movies: [MTMovie]!
    var selectedIndex: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.allowsMultipleSelection = true
        collectionView?.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
    }
}

extension MTMovieViewController {
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCell
        if movies[indexPath.row].posterImage != nil {
            cell.configureCell(movies[indexPath.row])
        }
        return cell
    }
}

extension MTMovieViewController {
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        if let selected = selectedIndex {
            let selectedCell = collectionView.cellForItem(at: selected) as! MovieCell
            unhighlight(cell: selectedCell)
        }
        let cell = collectionView.cellForItem(at: indexPath) as! MovieCell
        cell.isSelected = true
        cell.selectedStyle()
        selectedIndex = indexPath
        return true
    }
    
    func unhighlight(cell: MovieCell) {
        cell.isSelected = false
        cell.selectedStyle()
    }
}
