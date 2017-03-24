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
    
    @IBOutlet weak var searchField: UITextField! {
        didSet {
            searchField.layer.cornerRadius = 4
            searchField.layer.borderColor = UIColor.lightGray.cgColor
            searchField.layer.borderWidth = 1
        }
    }
    @IBOutlet weak var searchButton: UIButton! {
        didSet {
            searchButton.layer.cornerRadius = 4
            searchButton.layer.borderColor = UIColor.lightGray.cgColor
            searchButton.layer.borderWidth = 1
        }
    }
    
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
        
        commonConstraints(for: contentView)
        contentView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        contentView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        
        
        commonConstraints(for: contentView)
        searchField.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        searchField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: SearchViewConstants.searchFieldWidthMultiplier).isActive = true
        searchField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: SearchViewConstants.heightMultiplier).isActive = true
        
        
        commonConstraints(for: searchButton)
        searchButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: SearchViewConstants.buttonCenterYOffeset).isActive = true
        searchButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: SearchViewConstants.buttonWidthMultiplier).isActive = true
        searchButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: SearchViewConstants.heightMultiplier).isActive = true
    }
    
    func commonConstraints(for element: UIView) {
        element.translatesAutoresizingMaskIntoConstraints = false
        element.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

}

struct SearchViewConstants {
    static let buttonCenterYOffeset: CGFloat = UIScreen.main.bounds.height * 0.2
    static let buttonWidthMultiplier: CGFloat = 0.4
    static let heightMultiplier: CGFloat =  0.08
    static let searchFieldWidthMultiplier: CGFloat = 0.7
}


