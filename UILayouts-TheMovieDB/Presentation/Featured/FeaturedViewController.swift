//
//  FeaturedViewController.swift
//  UILayouts-TheMovieDB
//
//  Created by Mwai Banda on 8/25/22.
//

import UIKit
import RxSwift


class FeaturedViewController: UIViewController {
    private let featuredViewModel = FeaturedViewModel()
    private let disposeBag = DisposeBag()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 10, right: 20)
        layout.itemSize = CGSize(width: view.safeAreaLayoutGuide.layoutFrame.size.width * 0.42, height: 260)
        let collectionView  = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(FeaturedCollectionViewCell.self, forCellWithReuseIdentifier: FeaturedCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .systemGray5
        navigationController?.tabBarController?.tabBar.barTintColor = .systemGray5
        featuredViewModel.getTrendingMovies()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        title = Constants.FEATURED
        
        view.addSubview(collectionView)
        
        setupConstraints()
        setupSubscribers()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func setupSubscribers() {
        featuredViewModel.movies.bind(
            to: collectionView.rx.items(
                cellIdentifier: FeaturedCollectionViewCell.identifier,
                cellType: FeaturedCollectionViewCell.self
            )
        ){ _, movie, cell in
            cell.coverImage?.sd_setImage(with: movie.posterImageUrl, placeholderImage: UIImage(named: "placeholder"), options: [.highPriority])
            cell.movieTitle.text = movie.title
            
        }.disposed(by: disposeBag)
        
        collectionView.rx
            .modelSelected(Movie.self)
            .bind{ movie in
                print(movie.title)
            }.disposed(by: disposeBag)
    }
    
}
