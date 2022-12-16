//
//  CartView.swift
//  Ecommerce Concept
//
//  Created by Андрей on 16.12.2022.
//

import UIKit
import SnapKit

final class CartView: UIView {
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "My Cart"
        label.font = .systemFont(ofSize: 35, weight: .bold)
        return label
    }()
    
    var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Midnight")
        view.layer.cornerRadius = 30
        
        return view
    }()
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(named: "Midnight")
        tableView.register(CartCell.self, forCellReuseIdentifier: CartCell.id)
        return tableView
    }()
    
    var totalLabel: UILabel = {
        let label = UILabel()
        label.text = "Total"
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    var deliveryLabel: UILabel = {
        let label = UILabel()
        label.text = "Delivery"
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    var totalPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    var deliveryPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    var topSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    var bottomSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    var checkoutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "AccentColor")
        button.setTitle("Checkout", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    var leftVStack: UIStackView = {
        let stack = UIStackView()
        return stack
    }()
    
    var rightVStack: UIStackView = {
        let stack = UIStackView()
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "Background")
        
        makeSubViews()
        makeConstraints()
    }
    
    private func makeSubViews() {
        leftVStack = UIStackView(arrangedSubviews: [totalLabel, deliveryLabel],
                                 axis: .vertical,
                                 distribution: .fillEqually)
        rightVStack = UIStackView(arrangedSubviews: [totalPriceLabel, deliveryPriceLabel],
                                  axis: .vertical,
                                  distribution: .fillEqually)
        
        containerView.addSubview(tableView)
        containerView.addSubview(topSeparator)
        containerView.addSubview(leftVStack)
        containerView.addSubview(rightVStack)
        containerView.addSubview(bottomSeparator)
        containerView.addSubview(checkoutButton)
        
        addSubview(titleLabel)
        addSubview(containerView)
    }
    
    private func makeConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(height*0.17)
            make.leading.equalTo(width*0.1)
            make.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.06)
        }
        
        containerView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.72)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(height*0.72*0.11)
            make.leading.trailing.equalToSuperview().inset(width*0.08)
            make.height.equalToSuperview().multipliedBy(0.57)
        }
        
        topSeparator.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(2)
        }
        
        leftVStack.snp.makeConstraints { make in
            make.top.equalTo(topSeparator.snp.bottom)
            make.leading.equalToSuperview().inset(width*0.13)
            make.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.13)
        }
        
        rightVStack.snp.makeConstraints { make in
            make.top.equalTo(topSeparator.snp.bottom)
            make.trailing.equalToSuperview().inset(width*0.08)
            make.height.equalToSuperview().multipliedBy(0.13)
        }
        
        bottomSeparator.snp.makeConstraints { make in
            make.top.equalTo(leftVStack.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        checkoutButton.snp.makeConstraints { make in
            make.top.equalTo(bottomSeparator.snp.bottom).offset(height*0.72*0.04)
            make.leading.trailing.equalToSuperview().inset(width*0.1)
            make.height.equalToSuperview().multipliedBy(0.07)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
