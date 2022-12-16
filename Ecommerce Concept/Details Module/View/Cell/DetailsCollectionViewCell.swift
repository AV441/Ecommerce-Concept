//
//  DetailsCollectionViewCell.swift
//  Ecommerce Concept
//
//  Created by Андрей on 13.12.2022.
//

import UIKit
import SnapKit

final class DetailsCollectionViewCell: UICollectionViewCell {
    static let id = "DetailsCollectionViewCell"
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 30
        layer.shadowRadius = 20
        layer.shadowColor = UIColor(red: 0.216, green: 0.305, blue: 0.533, alpha: 0.16).cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 10)
        backgroundColor = .white
        
        addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.bottom.equalToSuperview().inset(7)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with imageAddress: String) {
        guard let imageURL = URL(string: imageAddress) else { return }
        imageView.sd_setImage(with: imageURL)
    }
    
}


