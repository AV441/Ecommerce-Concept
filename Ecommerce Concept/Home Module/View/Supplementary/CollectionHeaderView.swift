//
//  CollectionHeaderView.swift
//  Ecommerce Concept
//
//  Created by Андрей on 10.12.2022.
//

import UIKit
import SwiftUI

final class CollectionHeaderView: UICollectionReusableView {
    static let id = String(describing: CollectionHeaderView.self)
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private var button: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        button.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(button)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRect(x: 17,
                                  y: 0,
                                  width: 200,
                                  height: 32)
        
        button.frame = CGRect(x: UIScreen.width - 104,
                              y: 0,
                              width: 84,
                              height: 32)
    }
    
    func configure(with section: HomeScreenSection) {
        switch section {
        case .selectCategory:
            titleLabel.text = section.rawValue
            button.setTitle("view all", for: .normal)
        case .search:
            break
        case .hotSales:
            titleLabel.text = section.rawValue
            button.setTitle("see more", for: .normal)
        case .bestSeller:
            titleLabel.text = section.rawValue
            button.setTitle("see more", for: .normal)
        }
    }
    
}
