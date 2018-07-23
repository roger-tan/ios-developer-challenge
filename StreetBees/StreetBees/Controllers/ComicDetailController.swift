//
//  ComicDetailController.swift
//  StreetBees
//
//  Created by Roger TAN on 21/07/2018.
//  Copyright © 2018 Roger TAN. All rights reserved.
//

import UIKit

final class ComicDetailController: UIViewController {
    
    // MARK: - Initializers
    
    init(viewModel: ComicViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.accessibilityIdentifier = "comic_detail"
        configureViews()
        configureAutolayout()
    }
    
    // MARK: - Actions
    
    @objc func closeAction() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Private Methods
    
    private func configureViews() {
        view.addSubview(imageView)
        view.addSubview(closeButton)
        guard let image = viewModel.image else {
            return
        }
        URLSession.shared.dataTask(with: image) { [weak self] (data, _, _) in
            if let data = data {
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: data)
                }
            }
        }.resume()
    }
    
    private func configureAutolayout() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            ])
    }
    
    // MARK: - UIViews

    lazy private(set) var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy private(set) var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(NSLocalizedString("Close", comment: "Close"), for: .normal)
        button.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Stored Properties
    
    let viewModel: ComicViewModel
    
}
