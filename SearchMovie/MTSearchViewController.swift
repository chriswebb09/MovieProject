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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardOnTap()
        searchView.frame = view.frame
        searchView.delegate = self
        searchView.searchField.delegate = self
    }
    
    // MARK: - Initialization with MTDataStore
    
    init(dataStore: MTMovieDataStore) {
        super.init(nibName: "MTSearchViewController", bundle: nil)
        self.dataStore = dataStore
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    // MARK: - SearchView Delegate
    
    func searchButtonTappedWithTerm(_ searchTerm: String) {
        print(searchTerm)
        dataStore = MTMovieDataStore(searchTerm: searchTerm)
        searchView.searchField.text = nil
        let destinationVC = MTMovieViewController(nibName: "MTMovieViewController", bundle: nil)
        getMovies { movies in
            DispatchQueue.main.async {
                let newMovies = movies
                destinationVC.movies = newMovies
                self.searchView.hideIndicator()
                self.navigationController?.pushViewController(destinationVC, animated: false)
            }
        }
    }
    
    // MARK: - Search logic
    
    func getMovies(completion: @escaping ([MTMovie]) -> Void) {
        if let store = dataStore {
            store.fetchNextPage { pageNumber in
                store.sendCall(pageNumber: pageNumber) { movies in
                    guard movies != nil else {
                        let delay = DispatchTime.now() + 1
                        DispatchQueue.main.asyncAfter(deadline: delay) {
                            self.searchView.hideIndicator()
                        }
                        return }
                    if let movies = movies {
                        completion(movies)
                    }
                }
            }
        }
    }
}

extension MTSearchViewController {
    
    // MARK: - Keyboard logic
    
    func hideKeyboardOnTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
