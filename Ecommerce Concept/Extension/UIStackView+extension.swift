//
//  UIStackView+extension.swift
//  Ecommerce Concept
//
//  Created by Андрей on 12.12.2022.
//

import UIKit

extension UIStackView {

    convenience init(arrangedSubviews: [UIView],
                     axis: NSLayoutConstraint.Axis,
                     distribution: UIStackView.Distribution = .fill,
                     alignment: UIStackView.Alignment = .fill,
                     spacing: CGFloat = 0) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
    }
}
