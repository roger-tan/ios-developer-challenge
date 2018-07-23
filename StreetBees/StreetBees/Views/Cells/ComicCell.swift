//
//  ComicCell.swift
//  StreetBees
//
//  Created by Roger TAN on 21/07/2018.
//  Copyright © 2018 Roger TAN. All rights reserved.
//

import UIKit

class ComicCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        accessibilityIdentifier = "comic"
        configureViews()
        configureAutolayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Public Methods
    
    func configure(viewModel: ComicViewModel) {
        if let url = viewModel.thumbnail {
            configureImageView(url: url)
        }
    }
    
    private func configureImageView(url: URL) {
        activityIndicator.startAnimating()
        URLSession.shared.dataTask(with: url) { [weak self] (data, _, _) in
            if let data = data {
                DispatchQueue.main.async {
                    self?.imageView.accessibilityValue = url.absoluteString
                    self?.imageView.image = UIImage(data: data)
                    self?.activityIndicator.stopAnimating()
                }
            }
        }.resume()
    }
    
    // MARK: - Private Methods
    
    private func configureViews() {
        addSubview(imageView)
        addSubview(activityIndicator)
        backgroundColor = .white
    }
    
    private func configureAutolayout() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            ])
    }
    
    lazy private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.accessibilityIdentifier = "image"
        imageView.isAccessibilityElement = true
        
        return imageView
    }()
    
    lazy private var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        return activityIndicator
    }()
}
