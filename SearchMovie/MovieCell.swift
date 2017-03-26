//
//  MovieCell.swift
//  MovieTumble
//
//  Created by Christopher Webb-Orenstein on 3/25/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func selectedStyle() {
        posterImageView.isHidden = isSelected
        backgroundColor = isSelected ? .red : .gray
    }
    
    func configureCell(_ movie: MTMovie) {
        posterImageView.image = movie.posterImage
        titleLabel.text = movie.title
    }

}
