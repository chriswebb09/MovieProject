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
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    @IBOutlet fileprivate weak var searchBar: UISearchBar!
    @IBOutlet fileprivate weak var collectionViewLayout: UICollectionViewFlowLayout!
    
    fileprivate var dataSource: MTMovieDataSource?
    var timer = Timer()
    
    convenience init() {
        self.init(nibName: "MTMovieViewController", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        setupCollectionView()
        setupCollectionView()
        content = Bundle.main.loadNibNamed("MTEmptyMovieView",
                                           owner: self,
                                           options: nil)?[0] as! MTEmptyMovieView
        view.addSubview(collectionView)
        setViewFrame(view: collectionView)
        view.addSubview(content)
        setViewFrame(view: content)
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
        let topOffset: CGFloat = UIScreen.main.bounds.size.height * 0.059
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
        if let movie = dataSource?.movies[indexPath.row] {
            cell.configureCell(with: movie)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.movies.count ?? 0
    }
}

// MARK: - UISearchBarDelegate

extension MTMovieViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        view.bringSubview(toFront: collectionView)
        searchForMovie(with: searchText)
    }
}

// MARK: - UISearchResultsUpdating

extension MTMovieViewController: UISearchResultsUpdating {
    
    func searchForMovie(with term: String) {
        dataSource = MTMovieDataSource(searchTerm: term)
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.5,
                                     target: self,
                                     selector: #selector(startCall),
                                     userInfo: nil,
                                     repeats: false)
    }
    
    func startCall() {
        dataSource?.fetchNextPage { movieResults, error in
            if self.dataSource?.movies.count == 0 {
                self.view.bringSubview(toFront: self.content)
            }
            self.collectionView.reloadData()
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        // Implement
    }
}
