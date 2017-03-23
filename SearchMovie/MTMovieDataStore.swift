//
//  MTMovieDataStore.swift
//  MovieTumble
//
//  Created by Christopher Webb-Orenstein on 3/22/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

final class MTMovieDataStore {
    
    private var pageNumber = 1
    private var totalResults: String?
    private var response: Response?
    private var searchTerm: String?

    func fetchQuery(for movieQuery: String) {
        searchTerm = movieQuery
    }
    
    func fetchNextPage() {
        pageNumber += 1
    }
    
    func sendCall(completion: @escaping ([MTMovie?]) -> Void) {
        if let search = searchTerm {
            MTAPIClient.search(for: search, forPage: "5") { movieData in
                var movies = [MTMovie]()
                for movie in 1..<movieData.count {
                    if let newMovie = MTMovie(movieData[movie]!) {
                        movies.append(newMovie)
                    }
                }
                completion(movies)
            }
        }
    }
}
