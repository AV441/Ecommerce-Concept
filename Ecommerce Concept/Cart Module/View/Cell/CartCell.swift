//
//  CartCell.swift
//  Ecommerce Concept
//
//  Created by Андрей on 16.12.2022.
//

import UIKit
import SnapKit

protocol CartCellDelegate: AnyObject {
    func plusButtonTapped(onItem item: BasketItem)
    func minusButtonTapped(onItem item: BasketItem)
    func trashButtonTapped(onItem item: BasketItem)
}

final class CartCell: UITableViewCell {
    static let id = String(describing: CartCell.self)
    
    weak var delegate: CartCellDelegate?
    
    private var item: BasketItem!
    
    private var pictureView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "MarkPro-Medium", size: 20)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    private var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "MarkPro-Medium", size: 20)
        label.textColor = UIColor(named: "AccentColor")
        return label
    }()
    
    private var VStack: UIStackView = {
        let stack = UIStackView()
        stack.layer.cornerRadius = 26
        stack.backgroundColor = .gray
        return stack
    }()
    
    private var minusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icMinus"), for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    private var plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icPlus"), for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    private var countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "MarkPro-Medium", size: 20)
        label.textColor = .white
        label.text = "1"
        label.backgroundColor = .clear
        return label
    }()
    
    private var trashButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icTrash"), for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(named: "Midnight")
        selectionStyle = .none
        contentView.isUserInteractionEnabled = false
        
        makeSubViews()
        makeConstraints()
        addTargets()
    }
    
    private func makeSubViews() {
        VStack = UIStackView(arrangedSubviews: [minusButton, countLabel, plusButton],
                             axis: .vertical,
                             distribution: .fillEqually,
                             alignment: .center)
        VStack.layer.cornerRadius = 13
        VStack.backgroundColor = UIColor(named: "DarkGray")
        
        addSubview(pictureView)
        addSubview(titleLabel)
        addSubview(priceLabel)
        addSubview(VStack)
        addSubview(trashButton)
    }
    
    private func makeConstraints() {
        pictureView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalTo(pictureView.snp.height)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(pictureView.snp.trailing).offset(width*0.04)
            make.bottom.equalTo(priceLabel.snp.top)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.leading.equalTo(pictureView.snp.trailing).offset(width*0.04)
            make.bottom.equalToSuperview()
            make.trailing.equalTo(VStack.snp.leading)
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        
        VStack.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(titleLabel.snp.trailing)
            make.width.equalTo(26)
            make.height.equalToSuperview()
        }
        
        trashButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(VStack.snp.trailing).offset(width*0.04)
            make.trailing.equalToSuperview()
            make.width.height.equalTo(20)
        }
    }
    
    private func addTargets() {
        minusButton.addTarget(self, action: #selector(didTapMinusButton), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
        trashButton.addTarget(self, action: #selector(didTapTrashButton), for: .touchUpInside)
    }
    
    @objc
    private func didTapMinusButton() {
        delegate?.minusButtonTapped(onItem: item)
    }
    
    @objc
    private func didTapPlusButton() {
        delegate?.plusButtonTapped(onItem: item)
    }
    
    @objc
    private func didTapTrashButton() {
        delegate?.trashButtonTapped(onItem: item)
    }
    
    public func configure(with item: BasketItem) {
        self.item = item
        titleLabel.text = item.title
        priceLabel.text = "$\(item.price.formattedWithSeparator)"
        countLabel.text = String(describing: item.count ?? 1)
        
        guard let url = URL(string: item.images) else { return }
        pictureView.sd_setImage(with: url)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
