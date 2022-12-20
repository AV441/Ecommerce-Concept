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
    
//    convenience init(title: String) {
//        self.init()
//        self.setTitle(title, for: .normal)
//        self.setTitleColor(.black, for: .selected)
//        self.setTitleColor(.gray, for: .normal)
//        self.titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
//    }
//    
//    func makeSelector() -> UIView {
//        let view = UIView()
//        view.backgroundColor = UIColor(named: "AccentColor")
//        view.layer.cornerRadius = 1.5
//        return view
//    }
//    
//    var selector: UIView {
//        return makeSelector()
//    }
//    
//    func setSelected() {
//        self.isSelected = true
//        self.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
//        
//        self.addSubview(selector)
//        
//        selector.snp.makeConstraints { make in
//            make.top.equalTo(self.snp.bottom)
//            make.leading.trailing.equalToSuperview()
//            make.height.equalTo(3)
//        }
//    }
//    
//    func setNormal() {
//        self.isSelected = false
//        self.titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
//        self.selector.removeFromSuperview()
//    }
}
