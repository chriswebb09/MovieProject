//
//  UIImageView+Extension.swift
//  MovieTumble
//
//  Created by Christopher Webb-Orenstein on 3/29/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func downloadImage(with url: URL, placeholderImage: UIImage?) {
        MTAPIClient.downloadImage(url: url) { image, error in
            if error != nil {
                print(error?.localizedDescription ?? "Unable to download image, no specific error")
            } else {
                self.image = image
            }
        }
    }
}
