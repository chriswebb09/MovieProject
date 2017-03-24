//
//  MTSearchViewController.swift
//  MovieTumble
//
//  Created by Christopher Webb-Orenstein on 3/23/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class MTSearchViewController: UIViewController {
    
    var store = MTMovieDataStore()

    @IBOutlet var searchView: MTSearchView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = searchView
        searchView.searchButton.addTarget(self,
                                          action: #selector(onSearch),
                                          for: .touchUpInside)
    }
    
   
    init(_ coder: NSCoder? = nil, store: MTMovieDataStore = MTMovieDataStore()) {
        self.store = store
        if let coder = coder {
            super.init(coder: coder)!
        } else {
            super.init(nibName: nil, bundle:nil)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func onSearch() {
        let searchTerm = searchView.searchField.text
        if let searchText = searchTerm {
            store.fetchQuery(for: searchText)
            store.sendCall { movie in
                print(movie)
            }
        }
    }
}

extension UIViewController {
    
    func hideKeyboardOnTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

