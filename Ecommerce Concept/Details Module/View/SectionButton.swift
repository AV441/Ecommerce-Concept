//
//  SectionButton.swift
//  Ecommerce Concept
//
//  Created by Андрей on 14.12.2022.
//

import UIKit

/// This class inheriteted from UIButton creates and manages section picker buttons for Details Screen
final class SectionButton: UIButton {
    
    convenience init(title: String) {
        self.init()
        self.setTitle(title, for: .normal)
        self.setTitleColor(.black, for: .selected)
        self.setTitleColor(.gray, for: .normal)
        self.titleLabel?.font = UIFont(name: "MarkPro", size: 20)
    }
    
    private var selectorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "AccentColor")
        view.layer.cornerRadius = 1.5
        return view
    }()
    
    /// sets isSelected state to "true" and changes visual representation
    func setSelected() {
        self.isSelected = true
        self.titleLabel?.font = UIFont(name: "MarkPro-Bold", size: 20)
        self.addSubview(selectorView)
        
        selectorView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(3)
        }
    }
    
    /// sets isSelected state to "false" and changes visual representation
    func setNormal() {
        self.isSelected = false
        self.titleLabel?.font = UIFont(name: "MarkPro", size: 20)
        self.selectorView.removeFromSuperview()
    }
    
}
