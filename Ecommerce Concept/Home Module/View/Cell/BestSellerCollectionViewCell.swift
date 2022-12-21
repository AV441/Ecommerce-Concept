//
//  BestSellerCollectionViewCell.swift
//  Ecommerce Concept
//
//  Created by Андрей on 10.12.2022.
//

import UIKit
import SDWebImage

protocol BestSellerCellDelegate: AnyObject {
    func didTapLikeButton(sender: UICollectionViewCell)
}

final class BestSellerCollectionViewCell: UICollectionViewCell {
    static let id = String(describing: BestSellerCollectionViewCell.self)
    
    weak var delegate: BestSellerCellDelegate?
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "MarkPro", size: 10)
        label.textColor = .black
        label.text = "Samsung Galaxy s20 Ultra"
        return label
    }()
    
    private var salePriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "MarkPro-Bold", size: 16)
        label.textColor = .black
        label.textAlignment = .left
        label.layer.masksToBounds = true
        return label
    }()
    
    private var totalPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "MarkPro-Medium", size: 10)
        label.textColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        label.textAlignment = .left
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
        button.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
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
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.isUserInteractionEnabled = false
        
        makeSubviews()
        makeConstraints()
    }
    
    private func makeSubviews() {
        addSubview(imageView)
        addSubview(likeButton)
        addSubview(titleLabel)
        addSubview(totalPriceLabel)
        addSubview(salePriceLabel)
    }
    
    private func makeConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(168)
        }
        
        likeButton.snp.makeConstraints { make in
            make.width.height.equalTo(25)
            make.trailing.equalToSuperview().inset(13)
            make.top.equalToSuperview().offset(11)
        }
        
        salePriceLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.bottom.equalTo(titleLabel.snp.top).offset(-5)
            make.leading.equalToSuperview().offset(width*0.11)
            make.width.equalTo(50)
        }
        
        totalPriceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(salePriceLabel.snp.bottom)
            make.leading.equalTo(salePriceLabel.snp.trailing).offset(7)
            make.trailing.equalToSuperview().inset(width*0.11)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(width*0.11)
            make.height.equalToSuperview().multipliedBy(0.06)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        likeButton.layer.cornerRadius = likeButton.height/2
    }

    func configure(withItem item: BestSellerItem) {
        titleLabel.text = item.title
        salePriceLabel.text = "$" + item.priceWithoutDiscount.description
        let attributeString = NSMutableAttributedString(string: "$" + item.discountPrice.description)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                         value: 1,
                                         range: NSRange(location: 0, length: attributeString.length))
        totalPriceLabel.attributedText = attributeString
        
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
    private func didTapLikeButton() {
            delegate?.didTapLikeButton(sender: self)
    }
    
}
