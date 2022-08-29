//
//  SearchViewController.swift
//  UILayouts-TheMovieDB
//
//  Created by Mwai Banda on 8/29/22.
//

import UIKit

class SearchViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title =  Constants.SEARCH
        view.backgroundColor = .systemGray5
    }
 

}
