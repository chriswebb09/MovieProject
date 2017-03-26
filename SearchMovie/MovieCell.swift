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
        titleLabel.backgroundColor = .white
        backgroundColor = isSelected ? .red : .gray
    }
    
    func configureCell(_ movie: MTMovie) {
        DispatchQueue.main.async {
            self.posterImageView.image = movie.posterImage
            self.titleLabel.text = movie.title
        }
    }
}