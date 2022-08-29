//
//  TrendingTableViewCell.swift
//  UILayouts-TheMovieDB
//
//  Created by Mwai Banda on 8/26/22.
//

import UIKit

class TrendingTableViewCell: UITableViewCell {
    static let identifier = "trendingTableViewCell"
    
    var coverImage: UIImageView? = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "placeholder")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    let vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        return stack
    }()
    
    var movieTitle: UILabel = {
        let label = PaddingLabel(withInsets: 0, 0, 4, 0)
        label.text = "Title"
        label.font = .preferredCustomFont(forTextStyle: .title3, weight: .heavy)
        return label
    }()
    var movieDescription: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.isUserInteractionEnabled = false
        textView.textContainer.maximumNumberOfLines = 5
        textView.font = .preferredFont(forTextStyle: .caption1)
        textView.text = "Description"
        textView.textContainer.lineBreakMode = .byTruncatingTail
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemGray5
        contentView.addSubview(coverImage!)
        contentView.addSubview(vStack)
        vStack.addArrangedSubview(movieTitle)
        vStack.addArrangedSubview(movieDescription)

    }
    
   
    override func layoutSubviews() {
        super.layoutSubviews()
        
        coverImage?.frame = CGRect(
            x: 20,
            y: 5,
            width: contentView.frame.size.height - 50,
            height: contentView.frame.size.height - 10
        )
        
        vStack.frame = CGRect(
            x: 25 + (coverImage?.frame.size.width ?? 0),
            y: 10,
            width: contentView.frame.size.width - ((coverImage?.frame.width ?? 0) + 30),
            height: contentView.frame.size.height - 15
        )
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    

}
