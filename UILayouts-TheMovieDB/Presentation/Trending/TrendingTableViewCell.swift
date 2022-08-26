//
//  TrendingTableViewCell.swift
//  UILayouts-TheMovieDB
//
//  Created by Mwai Banda on 8/26/22.
//

import UIKit

class TrendingTableViewCell: UITableViewCell {
    static let identifier = "trendingTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemGray5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
