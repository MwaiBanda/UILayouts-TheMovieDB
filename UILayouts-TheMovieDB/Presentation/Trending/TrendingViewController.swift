//
//  MovieListViewController.swift
//  UILayouts-TheMovieDB
//
//  Created by Mwai Banda on 8/25/22.
//

import UIKit

class TrendingViewController: UIViewController {
    private let trendingViewModel = TrendingViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        title = Constants.TRENDING_TITLE
        trendingViewModel.getTrendingMovies()
    }

}
