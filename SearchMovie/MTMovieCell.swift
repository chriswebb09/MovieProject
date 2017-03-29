//
//  MTMovieCell.swift
//  MovieTumble
//
//  Created by Christopher Webb-Orenstein on 3/28/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class MTMovieCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImageView.backgroundColor = .blue
    }
    
    func configureCell(with movie: MTMovie) {
        posterImageView.downloadImage(with: movie.posterImageURL, placeholderImage: nil)
    }
    
    func setStyle(selected: Bool) {
        posterImageView.isHidden = selected
        backgroundColor = selected ? .red : .gray
    }
    
    override func prepareForReuse() {
        posterImageView.image = nil
        super.prepareForReuse()
    }
}
