//
//  BrowseViewController.swift
//  UILayouts-TheMovieDB
//
//  Created by Mwai Banda on 8/28/22.
//

import UIKit
import RxSwift
import RxCocoa

class BrowseViewController: UIViewController {
    private let browseViewModel = BrowseViewModel()
    private let disposeBag = DisposeBag()
    
    private lazy var tableView: UITableView = {
        let table =  UITableView()
        table.register(BrowseTableViewCell.self, forCellReuseIdentifier: BrowseTableViewCell.identifier)
        table.backgroundColor = .clear
        table.showsVerticalScrollIndicator = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .systemGray5
        navigationController?.tabBarController?.tabBar.barTintColor = .systemGray5
        if browseViewModel.movies.value.isEmpty {
            browseViewModel.getMovies()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.BROWSE
        view.backgroundColor = .systemGray5
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
        browseViewModel.movies
            .bind(
                to: tableView.rx
                    .items(
                        cellIdentifier: BrowseTableViewCell.identifier,
                        cellType: BrowseTableViewCell.self
                    )
            ) { row, movies, cell in
                cell.delegate = self
                cell.configure(with: movies)
            }.disposed(by: disposeBag)
    }
}

extension BrowseViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
}

extension BrowseViewController: BrowseTableViewCellDelegate {
    
    func didSelectMovie(movie: Movie) {
        print(movie.title)
    }
}
