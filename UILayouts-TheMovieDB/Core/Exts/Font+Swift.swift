//
//  Font+Swift.swift
//  UILayouts-TheMovieDB
//
//  Created by Mwai Banda on 8/26/22.
//

import UIKit

extension UIFont {
    static func preferredCustomFont(forTextStyle textStyle: TextStyle, weight: Weight) -> UIFont {
        let defaultDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: textStyle)
        let size = defaultDescriptor.pointSize
        let fontDescriptor = UIFontDescriptor(fontAttributes: [
            UIFontDescriptor.AttributeName.size: size,
            UIFontDescriptor.AttributeName.family: UIFont.systemFont(ofSize: size).familyName
        ])

        let weightedFontDescriptor = fontDescriptor.addingAttributes([
            UIFontDescriptor.AttributeName.traits: [
                UIFontDescriptor.TraitKey.weight: weight
            ]
        ])
        return UIFont(descriptor: weightedFontDescriptor, size: 0)
    }
}
