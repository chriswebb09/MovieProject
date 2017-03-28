//
//  MovieCell.swift
//  MovieTumble
//
//  Created by Christopher Webb-Orenstein on 3/25/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

protocol MovieCellDelegate: class {
    func canDisplayImage(display: Bool)
}

final class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var posterImageView: UIImageView!
    
    func setup(hidden: Bool) {
        posterImageView.isHidden = hidden
        activityIndicator.hidesWhenStopped = true
    }
    
    func configureCell(poster: UIImage?) {
        if poster == nil {
            return 
        }
        posterImageView.image = poster
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 4
        setup(hidden: false)
        loadingLabel.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    func setStyle(selected: Bool) {
        posterImageView.isHidden = selected
        backgroundColor = selected ? .red : .gray
    }
    
    override func prepareForReuse() {
        posterImageView.image = nil
    }
}
