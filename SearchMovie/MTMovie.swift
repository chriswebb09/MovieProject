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
    let imageURL: URL?
    
    init?(_ json: [String : Any]) {
        if let title = json["Title"] as? String,
            let imdbID = json["imdbID"] as? String,
            let year = json["Year"] as? String,
            let imageURL = json["Poster"] as? String,
            let type = json["Type"] as? String,
            type == "movie"{
            self.title = title
            self.year = year
            self.imdbID = imdbID
            self.imageURL = URL(string: imageURL)
        } else {
            return nil
        }
    }
    
}
