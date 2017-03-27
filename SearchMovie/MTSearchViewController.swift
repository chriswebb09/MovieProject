//
//  MTSearchViewController.swift
//  MovieTumble
//
//  Created by Christopher Webb-Orenstein on 3/23/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class MTSearchViewController: UIViewController {
    
    // MARK: - Properties
    
    fileprivate var dataStore: MTMovieDataStore?
    @IBOutlet var searchView: MTSearchView!
    
    convenience init(dataStore: MTMovieDataStore) {
        self.init(nibName: "MTSearchViewController", bundle: nil)
        self.dataStore = dataStore
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardOnTap()
        searchView.frame = view.frame
        setupSearchViewDelegates()
        var font = UIFont(name: "Helvetica", size: 18)
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: font]
        title = "Movie Tumble"
    }
    
    // MARK: - Search logic
    
    func getMovies(completion: @escaping ([MTMovie]) -> Void) {
        if let store = dataStore {
            store.fetchNextPage { pageNumber in
                store.sendCall(pageNumber: pageNumber) { movies in
                    guard movies != nil else {
                        let delay = DispatchTime.now() + 1
                        DispatchQueue.main.asyncAfter(deadline: delay) {
                            self.searchView.hideIndicator() }
                        return
                    }
                    if let movies = movies {
                        completion(movies)
                    }
                }
            }
        }
    }
    
    // MARK: - Keyboard logic
    
    func hideKeyboardOnTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension MTSearchViewController: UITextFieldDelegate {
    
    // MARK: - Textfield delegate method
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

extension MTSearchViewController: SearchViewDelegate {
    
    func setupSearchViewDelegates() {
        searchView.searchField.delegate = self
        searchView.delegate = self
    }
    
    // MARK: - SearchView Delegate
    
    func searchButtonTappedWithTerm(with searchTerm: String) {
        print(searchTerm)
        dataStore = MTMovieDataStore(searchTerm: searchTerm)
        searchView.searchField.text = nil
        let destinationVC = MTMovieViewController(nibName: "MTMovieViewController", bundle: nil)
        getMovies { movies in
            DispatchQueue.main.async {
                destinationVC.movies = movies
                destinationVC.title = "Search term: \(searchTerm)"
                self.searchView.hideIndicator()
                self.navigationController?.pushViewController(destinationVC, animated: false)
            }
        }
    }
}
