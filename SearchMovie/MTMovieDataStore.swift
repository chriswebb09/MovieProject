//
//  MTMovieDataStore.swift
//  MovieTumble
//
//  Created by Christopher Webb-Orenstein on 3/22/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

final class MTMovieDataStore {
    
    private var pageNumber = 0
    private var totalResults: String?
    private var response: Response?
    private var searchTerm: String?

    func fetchQuery(for movieQuery: String) {
        searchTerm = movieQuery
        pageNumber += 1
    }
    
    func fetchNextPage() {
        
    }
    
    func downloadImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        MTAPIClient.downloadData(url: url) { data, response, error in
            if error != nil {
                print(error?.localizedDescription ?? "Unable to get specific error")
                completion(nil)
            }
            if let imageData = data {
                completion(UIImage(data: imageData))
            }
        }
    }
    
    func sendCall(completion: @escaping ([MTMovie]?) -> Void) {
        if let search = searchTerm {
            MTAPIClient.search(for: search, forPage: String(pageNumber)) { movieData in
                switch movieData {
                case .success(let json):
                    guard let search = json["Search"] as? [[String : String]] else { return }
                    var movies = [MTMovie]()
                    for movie in 0..<search.count {
                        if let newMovie = MTMovie(search[movie]) {
                            movies.append(newMovie)
                        }
                    }
                    completion(movies)
                case .badData(let error):
                    print(error.localizedDescription)
                    return
                case .badJSON(let error):
                    print(error.localizedDescription)
                    return
                case .badURL(let error):
                    print(error.localizedDescription)
                    return
                }
            }
        }
    }
}
