//
//  MTMovie.swift
//  MovieTumble
//
//  Created by Christopher Webb-Orenstein on 3/21/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

struct MTMovie: Equatable {
    
    let title: String
    let year: String
    let imdbID: String
    let posterImageURL: URL
    var posterImage: UIImage?
    
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
            self.posterImageURL = URL(string: imageURL)!
            self.posterImage = nil
        } else {
            return nil
        }
    }
    
    
    mutating func setImage(image: UIImage) {
        self.posterImage = image
    }
    
}

extension MTMovie: Hashable {

    public var hashValue: Int {
        return imdbID.hash
    }

    public static func ==(lhs: MTMovie, rhs: MTMovie) -> Bool {
        return lhs.imdbID == rhs.imdbID
    }
}
