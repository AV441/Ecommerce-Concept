//
//  BestSellerCollectionViewCell.swift
//  Ecommerce Concept
//
//  Created by Андрей on 10.12.2022.
//

import UIKit
import SDWebImage

protocol BestSellerCellDelegate {
    func likeButtonTapped(on item: BestSellerItem)
}

final class BestSellerCollectionViewCell: UICollectionViewCell {
    static let id = "BestSellerCollectionViewCell"
    
    var delegate: BestSellerCellDelegate?
    var item: BestSellerItem?
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.textColor = .black
        label.text = "Samsung Galaxy s20 Ultra"
        return label
    }()
    
    private var salePriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.text = "$1,000"
        label.textAlignment = .left
        label.layer.masksToBounds = true
        return label
    }()
    
    private var totalPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .medium)
        label.textColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        label.text = "$1,500"
        return label
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icLike"), for: .normal)
        button.backgroundColor = .white
        button.layer.masksToBounds = false
        button.layer.shadowOpacity = 1
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        button.layer.shadowRadius = 20
        button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 10
        
        addSubview(imageView)
        addSubview(likeButton)
        addSubview(titleLabel)
        addSubview(totalPriceLabel)
        addSubview(salePriceLabel)
        contentView.isUserInteractionEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: contentView.left,
                                 y: contentView.top,
                                 width: contentView.width,
                                 height: 168)
        
        likeButton.frame = CGRect(x: imageView.right - 37,
                                  y: imageView.top + 10,
                                  width: 25,
                                  height: 25)
        likeButton.layer.cornerRadius = likeButton.height/2
        
        salePriceLabel.frame = CGRect(x: contentView.left + 21,
                                      y: imageView.bottom + 2,
                                      width: 60,
                                      height: 20)
        
        totalPriceLabel.frame = CGRect(x: salePriceLabel.right + 7,
                                       y: imageView.bottom + 2,
                                       width: 50,
                                       height: 13)
        
        titleLabel.frame = CGRect(x: contentView.left + 21,
                                  y: salePriceLabel.bottom + 5,
                                  width: contentView.width - 21,
                                  height: 13)
        
    }

    func configure(withItem item: BestSellerItem) {
        self.item = item
        titleLabel.text = item.title
        salePriceLabel.text = "$" + item.priceWithoutDiscount.description
        totalPriceLabel.text = "$" + item.discountPrice.description
        
        if item.isFavorites == true {
            likeButton.setImage(UIImage(named: "icLikeFill"), for: .normal)
        } else {
            likeButton.setImage(UIImage(named: "icLike"), for: .normal)
        }
        
        guard let imageURL = URL(string: item.pictureURL) else {
            return
        }
        
        imageView.sd_setImage(with: imageURL)
    }
    
    @objc
    func likeButtonTapped() {
        if let item = item {
            delegate?.likeButtonTapped(on: item)
        }
    }
}
