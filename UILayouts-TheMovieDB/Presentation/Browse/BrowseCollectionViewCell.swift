//
//  BrowseCollectionViewCell.swift
//  UILayouts-TheMovieDB
//
//  Created by Mwai Banda on 8/28/22.
//

import UIKit
import RxSwift

protocol BrowseTableViewCellDelegate {
    func didSelectMovie(movie: Movie)
}
class BrowseTableViewCell: UITableViewCell {
    private var disposeBag = DisposeBag()
    static let identifier = "BrowseTableViewCell"
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 10, right: 20)
        layout.itemSize = CGSize(width: contentView.safeAreaLayoutGuide.layoutFrame.size.width * 0.55, height: 260)
        layout.scrollDirection  = .horizontal
        let collectionView  = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(FeaturedCollectionViewCell.self, forCellWithReuseIdentifier: FeaturedCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var delegate: BrowseTableViewCellDelegate?
    
    private var movies = PublishSubject<[Movie]>()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        contentView.backgroundColor = .systemGray5
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        setupSubscribers()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with movies: [Movie]) {
        self.movies.onNext(movies)
        self.movies.onCompleted()
        
    }
    
    
    func setupSubscribers() {
        movies.bind(
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
                self.delegate?.didSelectMovie(movie: movie)
            }.disposed(by: disposeBag)
    }
}

extension BrowseTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}



