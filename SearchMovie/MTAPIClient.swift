//
//  MTAPIClient.swift
//  MovieTumble
//
//  Created by Christopher Webb-Orenstein on 3/21/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation

typealias JSON = [String : Any]

class MTAPIClient {
    
    static func searchForMovie(_ string: String, handler: @escaping ([MTMovie]) -> Void) {
        let session = URLSession.shared
        let url = "http://www.omdbapi.com/?s=\(string.urlEncoded!)&page=2".asURL
        let request = URLRequest(url: url)
        var movies = [MTMovie]()
        
        session.dataTask(with: request) { data, response, error in
            let json = convertDataToJSON(data)
            guard let search = json?["Search"] as? [[String : String]] else { return }
            for movie in 1..<search.count {
                if let newMovie = MTMovie(search[movie]) {
                    movies.append(newMovie)
                }
            }; handler(movies) }.resume()
    }
    
    static func convertDataToJSON(_ data: Data?) -> JSON? {
        guard let data = data else { return nil }
        do {
            return try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? JSON
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

