//
//  HotSalesCollectionViewCell.swift
//  Ecommerce Concept
//
//  Created by Андрей on 10.12.2022.
//

import UIKit
import SDWebImage
import SnapKit

final class HotSalesCollectionViewCell: UICollectionViewCell {
    static let id = "HotSalesCollectionViewCell"
    
    private var isNewLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(named: "AccentColor")
        label.font = .systemFont(ofSize: 10, weight: .bold)
        label.textColor = .white
        label.text = "New"
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textColor = .white
        label.text = "Iphone 12"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .regular)
        label.textColor = .white
        label.text = "Súper. Mega. Rápido."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var button: UIButton = {
        let button = UIButton()
        button.setTitle("Buy now!", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 11, weight: .bold)
        button.layer.cornerRadius = 5
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addSubview(isNewLabel)
        
        isNewLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(25)
            make.top.equalToSuperview().offset(14)
            make.width.height.equalTo(27)
        }
        
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(isNewLabel.snp.bottom).offset(18)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview()
        }
        
        addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(25)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.trailing.equalToSuperview()
        }
        
        addSubview(button)
        
        button.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(25)
            make.top.equalTo(titleLabel.snp.bottom).offset(26)
            make.width.equalTo(98)
            make.height.equalTo(23)
        }
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        isNewLabel.frame = CGRect(x: contentView.left + 25,
//                                  y: contentView.top + 14,
//                                  width: 27,
//                                  height: 27)
        isNewLabel.layer.cornerRadius = isNewLabel.frame.height/2
//
//        titleLabel.frame = CGRect(x: contentView.left + 25,
//                                  y: contentView.top + 59,
//                                  width: imageView.width,
//                                  height: 30)
//
//        descriptionLabel.frame = CGRect(x: contentView.left + 25,
//                                        y: contentView.top + 94,
//                                        width: contentView.width,
//                                        height: 13)
//
//        button.frame = CGRect(x: contentView.left + 25,
//                              y: contentView.top + 133,
//                              width: 98,
//                              height: 23)
//
//        imageView.frame = contentView.bounds
        imageView.layer.cornerRadius = 10
    }
    
    func configure(withItem item: HotSaleItem) {
        titleLabel.text = item.title
        descriptionLabel.text = item.subtitle
        
        if item.isNew != nil {
            isNewLabel.isHidden = false
        } else {
            isNewLabel.isHidden = true
        }
        
        guard let imageURL = URL(string: item.pictureURL) else {
            return
        }
        
        imageView.sd_setImage(with: imageURL)
    }

}
