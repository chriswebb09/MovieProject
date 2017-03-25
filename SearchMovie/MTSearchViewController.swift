//
//  MTSearchViewController.swift
//  MovieTumble
//
//  Created by Christopher Webb-Orenstein on 3/23/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class MTSearchViewController: UIViewController {
    
    fileprivate var dataStore: MTMovieDataStore
    
    @IBOutlet var searchView: MTSearchView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = searchView
        searchView.searchButton.addTarget(self, action: #selector(onSearch), for: .touchUpInside)
    }
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.dataStore = MTMovieDataStore()
        super.init(nibName: "MTSearchViewController", bundle: nil)
        
    }
    
    convenience init(dataStore: MTMovieDataStore) {
        self.init(nibName: "MTSearchViewController", bundle: nil)
        self.dataStore = dataStore
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func onSearch() {
        guard let searchTerm = searchView.searchField.text else { return }
        searchView.searchField.text = nil
        dataStore.fetchQuery(for: searchTerm)
        dataStore.sendCall { movies in
            guard let movieCollection = movies else { return }
            for movie in movieCollection {
                guard let posterURL = movie.imageURL else { return }
                self.dataStore.downloadImage(url: posterURL) { posterImage in
                    dump(posterImage)
                }
            }
        }
    }
    
    func hideKeyboardOnTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

