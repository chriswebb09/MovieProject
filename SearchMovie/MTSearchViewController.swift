//
//  MTSearchViewController.swift
//  MovieTumble
//
//  Created by Christopher Webb-Orenstein on 3/23/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

final class MTSearchViewController: UIViewController {
    
    fileprivate var dataStore: MTMovieDataStore?
    @IBOutlet var searchView: MTSearchView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardOnTap()
        searchView.frame = view.frame
        setupSearchViewDelegates()
        var font = UIFont(name: "Helvetica", size: 18)
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: font]
        title = "Movie Tumble"
    }
    
    func getMovies(completion: @escaping ([MTMovie], String) -> Void) {
        if let store = dataStore {
            store.fetchNextPage(number: 0) { pageNumber in
                store.sendCall(pageNumber: pageNumber) { movies in
                    guard movies != nil else {
                        let delay = DispatchTime.now() + 1
                        DispatchQueue.main.asyncAfter(deadline: delay) {
                            self.searchView.hideIndicator()
                        }
                        return
                    }
                    if let movies = movies {
                        DispatchQueue.main.async {
                            self.searchView.hideIndicator()
                        }
                        completion(movies, pageNumber)
                        return
                    }
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

// MARK: - Textfield delegate

extension MTSearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

// MARK: - SearchView Delegate

extension MTSearchViewController: SearchViewDelegate {
    
    func setupSearchViewDelegates() {
        searchView.searchField.delegate = self
        searchView.delegate = self
    }
    
    func searchButtonTappedWithTerm(with searchTerm: String) {
        print(searchTerm)
        dataStore = MTMovieDataStore(searchTerm: searchTerm)
        searchView.searchField.text = nil
        let destinationVC = MTMovieViewController(nibName: "MTMovieViewController", bundle: nil)
        getMovies { movies in
            DispatchQueue.main.async {
                destinationVC.movies = movies.0
                destinationVC.searchTerm = searchTerm
                if let pageNumber = Int(movies.1) {
                    destinationVC.pagenumber = pageNumber
                }
                destinationVC.title = "Search term: \(searchTerm)"
                self.searchView.hideIndicator()
                self.navigationController?.pushViewController(destinationVC, animated: false)
            }
        }
    }
}
