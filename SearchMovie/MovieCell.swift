//
//  MovieCell.swift
//  MovieTumble
//
//  Created by Christopher Webb-Orenstein on 3/25/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

final class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func setup(hidden: Bool) {
        titleLabel.isHidden = hidden
        titleView.isHidden = hidden
        posterImageView.isHidden = hidden
        activityIndicator.hidesWhenStopped = true
    }
    
    func configureCell(title: String, poster: UIImage) {
        posterImageView.image = poster
        titleLabel.text = title
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 4
        setup(hidden: false)
        activityIndicator.stopAnimating()
    }
    
    func setStyle(selected: Bool) {
        posterImageView.isHidden = selected
        backgroundColor = selected ? .red : .gray
    }
}
