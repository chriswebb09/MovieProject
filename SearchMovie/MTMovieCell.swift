//
//  MTMovieCell.swift
//  MovieTumble
//
//  Created by Christopher Webb-Orenstein on 3/28/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class MTMovieCell: UICollectionViewCell {
    
    @IBOutlet weak var selectedView: UIView!
    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImageView.backgroundColor = .blue
    }
    
    func configureCell(with movie: MTMovie) {
        posterImageView.downloadImage(with: movie.posterImageURL, placeholderImage: #imageLiteral(resourceName: "star-white"))
        starImageView.image = #imageLiteral(resourceName: "stargold")
        selectedView.isHidden = true
    }
    
    func setStyle(selected: Bool) {
        selectedView.alpha = 0.5
        selectedView.isHidden = !selected
    }
    
    override func prepareForReuse() {
        posterImageView.image = nil
        super.prepareForReuse()
    }
}
