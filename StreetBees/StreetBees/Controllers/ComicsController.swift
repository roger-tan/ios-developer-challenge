//
//  ComicsController.swift
//  StreetBees
//
//  Created by Roger TAN on 21/07/2018.
//  Copyright © 2018 Roger TAN. All rights reserved.
//

import UIKit

class ComicsController: UIViewController {
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.accessibilityIdentifier = "comics"
        configureViews()
        configureAutoLayout()
        configureViewModel()
        viewModel.inputs.viewDidLoad()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Private Methods
    
    private func configureViews() {
        view.addSubview(collectionView)
        collectionView.register(ComicCell.self, forCellWithReuseIdentifier: String(describing: ComicCell.self))
    }
    
    private func configureAutoLayout() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            ])
    }
    
    private func configureViewModel() {
        viewModel.reloadData = {
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
        }
        
        viewModel.showComicDetail = { [weak self] comic in
            let controller = ComicDetailController(viewModel: comic)
            self?.present(controller, animated: true)
        }
        
    }

    // MARK: - UIViews
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .black
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    lazy var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.minimumLineSpacing = 10
        collectionViewFlowLayout.minimumInteritemSpacing = 10
        collectionViewFlowLayout.scrollDirection = .horizontal
        
        return collectionViewFlowLayout
    }()

    // MARK: - Stored Properties
    
    var viewModel: ComicsViewModelType = ComicsViewModel()

}

extension ComicsController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.outputs.numberOfRows()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ComicCell.self), for: indexPath) as? ComicCell, let comic = viewModel.outputs.comic(at: indexPath.row) else {
            return UICollectionViewCell()
        }
        cell.configure(viewModel: comic)
        
        return cell
    }

}

extension ComicsController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.inputs.select(at: indexPath.row)
    }
    
}

extension ComicsController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // (TODO): Make dynamic
        return CGSize(width: collectionView.frame.width / 3.5 , height: collectionView.frame.height / 4.5)
    }
}
