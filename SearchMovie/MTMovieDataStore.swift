//
//  MTMovieDataStore.swift
//  MovieTumble
//
//  Created by Christopher Webb-Orenstein on 3/22/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

final class MTMovieDataStore {
    
    fileprivate var searchTerm: String
    fileprivate var totalResults: String?
    fileprivate var pageNumber = 1
    
    init(searchTerm: String) {
        self.searchTerm = searchTerm
    }
    
    func fetchNextPage(completion: @escaping (_ movies: [MTMovie]?, _ error: Error?) -> Void) {
        MTAPIClient.search(for: searchTerm, page: pageNumber) { data, error in
            if let error = error {
                completion(nil, error)
            } else if let data = data, let moviesJSON = data["Search"] as? [[String : String]] {
                var movies = [MTMovie]()
                for movieJSON in moviesJSON {
                    if let movie = MTMovie(json: movieJSON) {
                        movies.append(movie)
                    }
                }
                self.pageNumber += 1
                completion(movies, nil)
            } else {
                completion(nil, NSError.generalParsingError(domain: ""))
            }
        }
    }
}
