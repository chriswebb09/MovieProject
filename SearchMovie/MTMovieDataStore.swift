//
//  MTMovieDataStore.swift
//  MovieTumble
//
//  Created by Christopher Webb-Orenstein on 3/22/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

final class MTMovieDataStore {
    
    private var totalResults: String?
    private var searchTerm: String
    
    init(searchTerm: String) {
        self.searchTerm = searchTerm
    }
    
    func fetchNextPage(number: Int, completion: @escaping (String) -> Void) {
        var page = number
        page += 1
        completion(String(page))
    }
    
    func sendCall(pageNumber: String, completion: @escaping ([MTMovie]?) -> Void) {
        var movies = [MTMovie]()
        MTAPIClient.search(for: searchTerm, page: pageNumber) { movieData, error in
            if let data = movieData {
                guard let search = data["Search"] as? [[String : String]] else { return }
                for movie in 0..<search.count {
                    let movie = MTMovie(search[movie])
                    if let movie = movie {
                        movies.append(movie)
                    }
                }
                completion(movies)
            }
        }
    }
}
