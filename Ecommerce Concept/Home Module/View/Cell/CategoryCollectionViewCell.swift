//
//  CategoryCollectionViewCell.swift
//  Ecommerce Concept
//
//  Created by Андрей on 10.12.2022.
//

import UIKit
import SnapKit

final class CategoryCollectionViewCell: UICollectionViewCell {
    static let id = "CategoryCollectionViewCell"
    
    var roundedView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var label: UILabel = {
        let label = UILabel()
        label.text = "Phones"
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(roundedView)
        
        roundedView.snp.makeConstraints { make in
            make.width.height.equalTo(71)
            make.top.leading.trailing.equalToSuperview()
        }
        
        roundedView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(32)
            make.center.equalToSuperview()
        }
        
        addSubview(label)
        
        label.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundedView.layer.cornerRadius = roundedView.frame.height/2
    }
    
    func configure(with categoryName: String, isSelected: Bool) {
        if isSelected {
            roundedView.backgroundColor = UIColor(named: "AccentColor")
            imageView.tintColor = .white
        } else {
            roundedView.backgroundColor = .white
            imageView.tintColor = UIColor(named: "CategoryGray")
        }
        
        imageView.image = UIImage(named: categoryName)
        label.text = categoryName
    }

}
