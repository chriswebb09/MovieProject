//
//  MTMovie.swift
//  MovieTumble
//
//  Created by Christopher Webb-Orenstein on 3/21/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation

struct MTMovie {
    
    let title: String
    let year: String
    let imdbID: String
    let imageURL: String
    
    init?(_ json: [String : String]) {
        if json["Type"] != "movie" { return nil }
        if let title = json["Title"], let imdbID = json["imdbID"], let year = json["Year"], let imageURL = json["Poster"] {
            self.title = title
            self.year = year
            self.imdbID = imdbID
            self.imageURL = imageURL
        } else {
            return nil
        }
    }
    
}
