//
//  CategoryCollectionViewCell.swift
//  Ecommerce Concept
//
//  Created by Андрей on 10.12.2022.
//

import UIKit
import SnapKit

final class CategoryCollectionViewCell: UICollectionViewCell {
    static let id = String(describing: CategoryCollectionViewCell.self)
    
    private var roundedView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 35
        return view
    }()
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var label: UILabel = {
        let label = UILabel()
        label.text = "Phones"
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeSubview()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeSubview() {
        addSubview(roundedView)
        roundedView.addSubview(imageView)
        addSubview(label)
    }
    
    private func makeConstraints() {
        roundedView.snp.makeConstraints { make in
            make.width.height.equalTo(70)
            make.top.leading.trailing.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(32)
            make.center.equalToSuperview()
        }
        
        label.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
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
