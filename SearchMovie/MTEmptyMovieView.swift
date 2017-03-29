//
//  MTEmptyMovieView.swift
//  MovieTumble
//
//  Created by Christopher Webb-Orenstein on 3/28/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class MTEmptyMovieView: UIView {
    @IBOutlet fileprivate weak var descriptionLabel: UITextView!
    @IBOutlet fileprivate weak var fillerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .gray
        fillerImageView.backgroundColor = .purple
    }
}
