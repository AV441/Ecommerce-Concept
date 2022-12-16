//
//  UIButton+extension.swift
//  Ecommerce Concept
//
//  Created by Андрей on 16.12.2022.
//

import UIKit

extension UIButton {
    
    convenience init(image: UIImage?) {
        self.init()
        self.setImage(image, for: .normal)
    }
}
