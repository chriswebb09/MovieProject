//
//  MTSearchView.swift
//  MovieTumble
//
//  Created by Christopher Webb-Orenstein on 3/23/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

class MTSearchView: UIView {
    
    @IBOutlet var contentView: UIView! {
        didSet {
             contentView.backgroundColor = .white
        }
    }
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: - Setup
    
    fileprivate func commonInit() {
        Bundle.main.loadNibNamed("MTSearchView", owner: self, options: nil)
        addSubview(contentView)
        layoutSubviews()
    }
    
    override func layoutSubviews() {
        setupConstraints()
    }
    
    func setupConstraints() {
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        contentView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        
        searchField.translatesAutoresizingMaskIntoConstraints = false
        searchField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        searchField.centerYAnchor.constraint(equalTo:centerYAnchor).isActive = true
        searchField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: SearchViewConstants.searchFieldWidthMultiplier).isActive = true
        searchField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: SearchViewConstants.heightMultiplier).isActive = true
        
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        searchButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: SearchViewConstants.buttonCenterYOffeset).isActive = true
        searchButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: SearchViewConstants.buttonWidthMultiplier).isActive = true
        searchButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: SearchViewConstants.heightMultiplier).isActive = true
    }

}

struct SearchViewConstants {
    static let buttonCenterYOffeset: CGFloat = UIScreen.main.bounds.height * 0.2
    static let buttonWidthMultiplier: CGFloat = 0.4
    static let heightMultiplier: CGFloat =  0.08
    static let searchFieldWidthMultiplier: CGFloat = 0.7
}


