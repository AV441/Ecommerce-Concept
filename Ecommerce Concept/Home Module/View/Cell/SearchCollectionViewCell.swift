//
//  SearchCollectionViewCell.swift
//  Ecommerce Concept
//
//  Created by Андрей on 10.12.2022.
//

import UIKit

final class SearchCollectionViewCell: UICollectionViewCell {
    static let id = String(describing: SearchCollectionViewCell.self)
    
    private var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.setImage(UIImage(named: "icLoupe"), for: .search, state: .normal)
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.searchTextField.backgroundColor = .clear
        searchBar.layer.backgroundColor = UIColor.white.cgColor
        searchBar.layer.masksToBounds = true
        return searchBar
    }()
    
    private var button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icQR"), for: .normal)
        button.backgroundColor = UIColor(named: "AccentColor")
        button.layer.masksToBounds = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(searchBar)
        addSubview(button)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        searchBar.frame = CGRect(x: contentView.left,
                                 y: 0,
                                 width: contentView.width - 41,
                                 height: 34)
        searchBar.layer.cornerRadius = searchBar.frame.height/2
        
        button.frame = CGRect(x: searchBar.right + 7,
                              y: 0,
                              width: 34,
                              height: 34)
        button.layer.cornerRadius = button.frame.height/2
    }
    
}
