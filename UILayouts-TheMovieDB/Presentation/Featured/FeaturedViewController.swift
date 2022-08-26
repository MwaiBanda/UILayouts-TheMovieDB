//
//  FeaturedViewController.swift
//  UILayouts-TheMovieDB
//
//  Created by Mwai Banda on 8/25/22.
//

import UIKit

class FeaturedViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .systemGray5
        navigationController?.tabBarController?.tabBar.barTintColor = .systemGray5
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        title = Constants.FEATURED_TITLE

    }

}
