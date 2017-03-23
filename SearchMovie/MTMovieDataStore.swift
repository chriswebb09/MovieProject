//
//  MTMovieDataStore.swift
//  MovieTumble
//
//  Created by Christopher Webb-Orenstein on 3/22/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

final class MTMovieDataStore {
    
    var movies: [MTMovie?]
    var pageNumber = 0
    var totalResults: String?
    var response: Response?
    var searchTerm: String?
    
    init() {
        self.movies = [MTMovie]()
    }
    
    func fetchQuery(for movieQuery: String) {
        self.searchTerm = movieQuery
    }
    
    func fetchNextPage() {
        self.pageNumber += 1 
    }
    
    func sendCall(completion: @escaping ([MTMovie?]) -> Void) {
        if let search = searchTerm {
            MTAPIClient.search(for: search, forPage: "5") { movieData in
                for movie in 1..<movieData.count {
                    if let newMovie = MTMovie(movieData[movie]) {
                        self.movies.append(newMovie)
                    }
                }
                completion(self.movies)
            }
        }
    }
}
