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
    static let id = String(describing: HotSalesCollectionViewCell.self)
    
    private var isNewLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(named: "AccentColor")
        label.font = .systemFont(ofSize: 10, weight: .bold)
        label.textColor = .white
        label.text = "New"
        label.textAlignment = .center
        label.layer.masksToBounds = true
        return label
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textColor = .white
        label.text = "Iphone 12"
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .regular)
        label.textColor = .white
        label.text = "Súper. Mega. Rápido."
        return label
    }()
    
    private var button: UIButton = {
        let button = UIButton()
        button.setTitle("Buy now!", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 11, weight: .bold)
        button.layer.cornerRadius = 5
        button.backgroundColor = .white
        return button
    }()
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeSubviews()
        makeConstraints()
    }
    
    private func makeSubviews() {
        addSubview(imageView)
        addSubview(isNewLabel)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(button)
    }
    private func makeConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        isNewLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(25)
            make.top.equalToSuperview().offset(14)
            make.width.height.equalTo(27)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(isNewLabel.snp.bottom).offset(18)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(25)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.trailing.equalToSuperview()
        }
        
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
        isNewLabel.layer.cornerRadius = isNewLabel.frame.height/2
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
