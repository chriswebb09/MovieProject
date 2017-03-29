//
//  MTMovieViewController.swift
//  MovieTumble
//
//  Created by Christopher Webb-Orenstein on 3/28/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

private let reuseIdentifier = "movieCell"

class MTMovieViewController: UIViewController {
    
    @IBOutlet weak var content: UIView!
    
    fileprivate var dataStore: MTMovieDataStore?
    fileprivate var movies: [MTMovie]?
    
    var timer: TimeInterval = 0
    
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    @IBOutlet fileprivate weak var searchBar: UISearchBar!
    @IBOutlet fileprivate weak var collectionViewLayout: UICollectionViewFlowLayout!
    
    convenience init() {
        self.init(nibName: "MTMovieViewController", bundle: nil)
        movies = []
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        content = Bundle.main.loadNibNamed("MTEmptyMovieView", owner: self, options: nil)?[0] as! MTEmptyMovieView
        view.addSubview(content)
        setViewFrame(view: content)
        setViewFrame(view: collectionView)
    }
    
    func setupCollectionView() {
        edgesForExtendedLayout = []
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "MTMovieCell", bundle: nil), forCellWithReuseIdentifier: "movieCell")
    }
    
    func setViewFrame(view: UIView) {
        let viewHeight: CGFloat = UIScreen.main.bounds.size.height * 0.9
        let viewWidth: CGFloat = UIScreen.main.bounds.size.width
        let topOffset: CGFloat = UIScreen.main.bounds.size.height * 0.1
        let viewFrame: CGRect = CGRect(x: 0, y: topOffset, width: viewWidth, height: viewHeight)
        view.frame = viewFrame
        
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
            print("Number of cells: \(movies.count)")
            return movies.count
        } else {
            return 0
        }
    }
}

// MARK: - UISearchBarDelegate

extension MTMovieViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer += 0.3
        view.addSubview(collectionView)
        setViewFrame(view: collectionView)
        searchForMovie(with: searchText)
        
    }
    
}

// MARK: - UISearchResultsUpdating

extension MTMovieViewController: UISearchResultsUpdating {
    
    func searchForMovie(with term: String) {
        dataStore = MTMovieDataStore(searchTerm: term)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + timer) {
            self.movies?.removeAll()
            self.dataStore?.fetchNextPage { movieResults, error in
                if movieResults == nil {
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                    return
                }
                
                if let moviesResults = movieResults {
                    self.movies?.append(contentsOf: moviesResults)
                    self.timer = 0
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                    
                }
            }
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        // Implment
    }
}
