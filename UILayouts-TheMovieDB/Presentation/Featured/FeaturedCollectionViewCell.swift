//
//  FeaturedCollectionViewCell.swift
//  UILayouts-TheMovieDB
//
//  Created by Mwai Banda on 8/27/22.
//

import UIKit

class FeaturedCollectionViewCell: UICollectionViewCell {
    static let identifier = "featuredUICollectionViewCell"

    var coverImage: UIImageView? = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "placeholder")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var movieTitle: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = .preferredCustomFont(forTextStyle: .footnote, weight: .heavy)
        label.heightAnchor.constraint(equalToConstant: 25).isActive = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let vStack: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .clear
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(vStack)
        vStack.addArrangedSubview(coverImage!)
        vStack.addArrangedSubview(movieTitle)

        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            vStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            vStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
