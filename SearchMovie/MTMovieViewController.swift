//
//  MTMovieViewController.swift
//  MovieTumble
//
//  Created by Christopher Webb-Orenstein on 3/28/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MovieCell"

class MTMovieViewController: UIViewController {
    
    fileprivate var dataStore: MTMovieDataStore?
    fileprivate var movies: [MTMovie]?
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    
    
    convenience init() {
        self.init(nibName: "MTSearchViewController", bundle: nil)
        self.movies = []
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        collectionView.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "MovieCell")
    }
}

// MARK: - UICollectionViewDelegate

extension MTMovieViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return false
    }
}

// MARK: - UICollectionViewDataSource

extension MTMovieViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MTMovieCell
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let movies = movies {
            return movies.count
        }
        return 0
    }
}

// MARK: - UISearchBarDelegate

extension MTMovieViewController: UISearchBarDelegate {
    // Implement
}

// MARK: - UISearchResultsUpdating

extension MTMovieViewController: UISearchResultsUpdating {
    
    func searchForMovie(with term: String) {
        dataStore = MTMovieDataStore(searchTerm: term)
        dataStore?.fetchNextPage { movieResults, error in
            if let moviesResults = movieResults {
                self.movies?.append(contentsOf: moviesResults)
                self.collectionView.reloadData()
            }
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        // Implment
    }
}
