//
//  SearchViewController.swift
//  UILayouts-TheMovieDB
//
//  Created by Mwai Banda on 8/29/22.
//

import UIKit
import RxSwift

class SearchViewController: UIViewController {
    let searchController: UISearchController = .init()
    private let searchViewModel = SearchViewModel()
    private let disposeBag = DisposeBag()
    
    private lazy var tableView: UITableView = {
        let table =  UITableView()
        table.register(TrendingTableViewCell.self, forCellReuseIdentifier: TrendingTableViewCell.identifier)
        table.backgroundColor = .systemGray5
        table.showsVerticalScrollIndicator = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        title =  Constants.SEARCH
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        
        view.addSubview(tableView)
        tableView.rx.setDelegate(self).disposed(by: disposeBag)

        setupConstraints()
        setupSubscribers()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            
        ])
    }
    
    func setupSubscribers() {
        
        searchViewModel.movies
            .bind(
                to: tableView.rx
                    .items(
                        cellIdentifier: TrendingTableViewCell.identifier,
                        cellType: TrendingTableViewCell.self
                    )
            ){ row, movie, cell in
                
                cell.coverImage?.sd_setImage(with: movie.posterImageUrl, placeholderImage: UIImage(named: "placeholder"), options: [.highPriority])
                cell.movieTitle.text = movie.title
                cell.movieDescription.attributedText = NSAttributedString(
                    string:  movie.overview.trimmingCharacters(in: .whitespacesAndNewlines),
                    attributes: [
                        .foregroundColor : UIColor.darkGray,
                        .font : UIFont.preferredFont(forTextStyle: .caption1)
                    ]
                )
            }.disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(Movie.self)
            .bind { movie in
                print(movie.title)
            }.disposed(by: disposeBag)
    }
 

}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        if text.count > 2 {
            searchViewModel.search(searchTerm: text)
        }
    }
    
}


extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    private func tableView(_ tableView: UITableView, titleForHeaderInSection
                                section: Int) -> String? {
       return "Header \(section)"
    }
  
}
