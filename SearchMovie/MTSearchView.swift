//
//  MTSearchView.swift
//  MovieTumble
//
//  Created by Christopher Webb-Orenstein on 3/23/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

protocol SearchViewDelegate: class {
    func searchButtonTappedWithTerm(with searchTerm: String)
}

final class MTSearchView: UIView {
    
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchTitleLabel: UILabel!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    weak var delegate: SearchViewDelegate?
    
    override func awakeFromNib() {
        Bundle.main.loadNibNamed("MTSearchView", owner: self, options: nil)
        addSubview(contentView)
        layoutSubviews()
        styleContent()
        setupIndicator()
        styleSearchField()
        setupSearchButton()
        styleSearchTitleLabel()
    }
    
    func setupIndicator() {
        activityIndicator.hidesWhenStopped = true
        indicatorView.isHidden = true
        indicatorView.layer.cornerRadius = 10
    }
    
    func styleSearchTitleLabel() {
        searchTitleLabel.text = "Search for movie"
    }
    
    func styleSearchField() {
        searchField.layer.borderColor = UIColor.lightGray.cgColor
        searchField.borderStyle = UITextBorderStyle.roundedRect
        searchField.layer.cornerRadius = 4
        searchField.layer.borderWidth = 1
    }
    
    func styleContent() {
        contentView.backgroundColor = .white
    }
    
    func setupSearchButton() {
        searchButton.addTarget(self, action: #selector(newSearch), for: .touchUpInside)
        searchButton.layer.borderColor = UIColor.lightGray.cgColor
        searchButton.layer.cornerRadius = 4
        searchButton.layer.borderWidth = 1
    }
    
    func hideIndicator() {
        DispatchQueue.main.async {
            self.indicatorView.isHidden = true
            self.activityIndicator.stopAnimating()
        }
    }
    
    func newSearch() {
        activityIndicator.startAnimating()
        indicatorView.isHidden = false
        if let searchText = searchField.text {
            delegate?.searchButtonTappedWithTerm(with: searchText)
        }
    }
}

