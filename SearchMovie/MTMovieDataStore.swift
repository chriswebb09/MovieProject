//
//  MTMovieDataStore.swift
//  MovieTumble
//
//  Created by Christopher Webb-Orenstein on 3/22/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

final class MTMovieDataStore {
    
    // MARK: - Properties
    
    private var pageNumber = 0
    private var totalResults: String?
    private var response: Response?
    private var searchTerm: String
    
    init(searchTerm: String) {
        self.searchTerm = searchTerm
    }
    
    // MARK: - Increments page number and returns it inside completion
    
    func fetchNextPage(completion: @escaping(String) -> Void) {
        pageNumber += 1
        completion(String(pageNumber))
    }
    
    func sendCall(pageNumber: String, completion: @escaping ([MTMovie]?) -> Void) {
        var movies = [MTMovie]()
        var fullMovieData = [MTMovie]()
        MTAPIClient.search(for: searchTerm, forPage: pageNumber) { movieData in
            
            switch movieData {
            case .success(let json):
                guard let search = json["Search"] as? [[String : String]] else { return }
                
                for movie in 0..<search.count {
                    let movie = MTMovie(search[movie])
                    if let movieFrame = movie {
                        movies.append(movieFrame)
                    }
                }
                
                movies.forEach { movie in
                    var newMovie = movie
                    MTAPIClient.downloadImage(url: newMovie.posterImageURL) { image in
                        newMovie.posterImage = image
                        fullMovieData.append(newMovie)
                        if fullMovieData.count == movies.count {
                            completion(fullMovieData)
                        }
                    }
                }
            case .badData(let error):
                print(error.localizedDescription)
                completion(nil)
                return
            case .badJSON(let error):
                print(error.localizedDescription)
                completion(nil)
                return
            case .badURL(let error):
                completion(nil)
                print(error.localizedDescription)
                return
            }
        }
    }
}
