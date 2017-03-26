//
//  MTSearchView.swift
//  MovieTumble
//
//  Created by Christopher Webb-Orenstein on 3/23/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

protocol SearchViewDelegate: class {
    func searchButtonTappedWithTerm(_ searchTerm: String)
}

class MTSearchView: UIView {
    
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchTitleLabel: UILabel!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    weak var delegate: SearchViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func awakeFromNib() {
        styleSearchTitleLabel()
        styleSearchButton()
        styleSearchField()
        setupIndicator()
        styleContent()
    }
    
    func setupIndicator() {
        activityIndicator.hidesWhenStopped = true
        indicatorView.isHidden = true
        indicatorView.layer.cornerRadius = 10
    }
    
    func styleSearchTitleLabel() {
        searchTitleLabel.text = "Search for movie"
        searchTitleLabel.sizeToFit()
    }
    
    func styleContent() {
        contentView.backgroundColor = .white
    }
    
    func styleSearchButton() {
        searchButton.layer.borderColor = UIColor.lightGray.cgColor
        searchButton.layer.cornerRadius = 4
        searchButton.layer.borderWidth = 1
    }
    
    func hideIndicator() {
        indicatorView.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    func styleSearchField() {
        searchField.layer.borderColor = UIColor.lightGray.cgColor
        searchField.borderStyle = UITextBorderStyle.roundedRect
        searchField.layer.cornerRadius = 4
        searchField.layer.borderWidth = 1
    }
    
    func newSearch() {
        activityIndicator.startAnimating()
        indicatorView.isHidden = false 
        delegate?.searchButtonTappedWithTerm(searchField.text!)
    }
    
    // MARK: - Setup
    
    fileprivate func commonInit() {
        Bundle.main.loadNibNamed("MTSearchView", owner: self, options: nil)
        addSubview(contentView)
        layoutSubviews()
        searchButton.addTarget(self, action: #selector(newSearch), for: .touchUpInside)
    }
}

