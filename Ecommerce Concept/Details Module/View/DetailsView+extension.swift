//
//  DetailsView+extension.swift
//  Ecommerce Concept
//
//  Created by Андрей on 14.12.2022.
//

import UIKit
import SnapKit
import Cosmos

extension DetailsView {

    func makeCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makelayout())
        collectionView.backgroundColor = UIColor(named: "Background")
        collectionView.alwaysBounceVertical = false
        collectionView.register(DetailsCollectionViewCell.self, forCellWithReuseIdentifier: DetailsCollectionViewCell.id)

        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.46)
        }
        return collectionView
    }
    
    func makelayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6),
                                               heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item,
                                                       count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 40
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 20, bottom: 10, trailing: 60)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    func makeContainerView() -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        addSubview(view)
        
        view.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.54)
        }
        return view
    }
    
    func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .medium)
        containerView.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(height*0.54*0.06)
            make.leading.equalToSuperview().offset(width*0.09)
            make.height.equalToSuperview().multipliedBy(0.07)
            make.trailing.equalTo(likeButton.snp.leading)
        }
        return label
    }
    
    func makeLikeButton() -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(named: "icLike"), for: .normal)
        button.setImage(UIImage(named: "icLikeFill"), for: .selected)
        button.backgroundColor = UIColor(named: "Midnight")
        button.tintColor = .white
        button.layer.cornerRadius = 10
        
        containerView.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.width.equalTo(37)
            make.height.equalTo(33)
            make.top.equalToSuperview().offset(height*0.54*0.06)
            make.trailing.equalToSuperview().inset(width*0.09)
        }
        
        button.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        return button
    }
    
    func makeRatingView() -> CosmosView {
        let view = CosmosView()
        view.settings.updateOnTouch = false
        containerView.addSubview(view)
        
        view.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(height*0.54*0.01)
            make.leading.equalToSuperview().offset(width*0.09)
            make.width.equalToSuperview().multipliedBy(0.24)
            make.height.equalTo(height*0.54*0.04)
        }
        return view
    }
    
    func makeSectionButtonsStack() -> UIStackView {
        createSectionButtons(sections: DetailsSection.allCases)
        let HStack = UIStackView(arrangedSubviews: sectionButtons,
                                 axis: .horizontal,
                                 distribution: .fillEqually)
        
        containerView.addSubview(HStack)

        HStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(width*0.06)
            make.height.equalToSuperview().multipliedBy(0.08)
            make.top.equalTo(ratingView.snp.bottom).offset(height*0.54*0.07)
        }
        return HStack
    }
    
    func createSectionButtons(sections: [DetailsSection]) {
        var tag = 0
        for section in sections {
            let button = SectionButton(title: section.rawValue)
            button.addTarget(self, action: #selector(didTapSectionButton), for: .touchUpInside)
            button.tag = tag
            tag += 1
            sectionButtons.append(button)
        }
        sectionButtons.first?.setSelected()
    }
    
    func makeCharacteristicLabel() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .regular)
        label.textColor = .gray
        return label
    }
    
    func makeCharacteristicImageView(withImageName name: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: name)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    func makeFeaturesStack() -> UIStackView {
        let cpuVStack = UIStackView(arrangedSubviews: [cpuImageView, cpuLabel],
                                    axis: .vertical,
                                    distribution: .fillProportionally,
                                    alignment: .center)
        let cameraVStack = UIStackView(arrangedSubviews: [cameraImageView, cameraLabel],
                                       axis: .vertical,
                                       distribution: .fillProportionally,
                                       alignment: .center)
        let ssdVStack = UIStackView(arrangedSubviews: [ssdImageView, ssdLabel],
                                    axis: .vertical,
                                    distribution: .fillProportionally,
                                    alignment: .center)
        let sdVStack = UIStackView(arrangedSubviews: [sdImageView, sdLabel],
                                   axis: .vertical,
                                   distribution: .fillProportionally,
                                   alignment: .center)
        
        let characteristics = [cpuVStack, cameraVStack, ssdVStack, sdVStack]
        
        let HStack = UIStackView(arrangedSubviews: characteristics,
                                 axis: .horizontal,
                                 distribution: .equalCentering,
                                 alignment: .fill)
        
        containerView.addSubview(HStack)
        
        HStack.snp.makeConstraints { make in
            make.top.equalTo(sectionButtonsStack.snp.bottom).offset(height*0.54*0.07)
            make.leading.equalToSuperview().offset(width*0.06)
            make.trailing.equalToSuperview().inset(width*0.09)
            make.height.equalToSuperview().multipliedBy(0.12)
        }
        return HStack
    }
    
    func makeSelectColorAndCapacityLabel() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.backgroundColor = .clear
        label.text = "Select color and capacity"
        
        containerView.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(width*0.07)
            make.trailing.equalToSuperview()
            make.top.equalTo(featuresStack.snp.bottom).offset(height*0.54*0.06)
            make.height.equalToSuperview().multipliedBy(0.05)
        }
        return label
    }
    
    func makeColorButtonsScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        
        containerView.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(width*0.08)
            make.top.equalTo(selectColorAndCapacityLabel.snp.bottom).offset(height*0.54*0.03)
            make.width.equalToSuperview().multipliedBy(0.3)
            make.height.equalTo(40)
        }
        return scrollView
    }
    
    func createColorButtons(colors: [String]) {
        var tag = 0
        for color in colors {
            let button = UIButton()
            button.backgroundColor = UIColor.hexColor(hex: color)
            button.layer.cornerRadius = 18
            button.setImage(UIImage(named: "icMark"), for: .selected)
            button.tag = tag
            tag += 1
            
            button.snp.makeConstraints { make in
                make.width.height.equalTo(36)
            }
            
            button.addTarget(self, action: #selector(didTapColorButton(sender:)), for: .touchUpInside)
            colorButtons.append(button)
        }
        
        colorButtons.first?.isSelected = true
        let colorButtonHStack = UIStackView(arrangedSubviews: colorButtons,
                                            axis: .horizontal,
                                            distribution: .equalSpacing,
                                            spacing: 19)
        colorButtonsScrollView.addSubview(colorButtonHStack)
        
        colorButtonHStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func makeCapacityButtonsScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
       
        containerView.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(selectColorAndCapacityLabel.snp.bottom).offset(height*0.54*0.04)
            make.trailing.equalToSuperview().inset(width*0.15)
            make.bottom.equalTo(addToCartStack.snp.top).offset(height*0.54*0.07)
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        return scrollView
    }
    
    func createCapacityButtons(capacityOptions: [String]) {
        var tag = 0
        capacityOptions.forEach { capacity in
            let button = UIButton()
            button.layer.cornerRadius = 10
            button.setTitle("\(capacity) GB", for: .selected)
            button.setTitle("\(capacity) gb", for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 13, weight: .bold)
            button.setTitleColor(.white, for: .selected)
            button.setTitleColor(.gray, for: .normal)
            button.setBackgroundImage(UIImage(named: "capacityButton"), for: .selected)
            button.tag = tag
            tag += 1
            
            button.snp.makeConstraints { make in
                make.width.equalTo(71)
                make.height.equalTo(30)
            }
            
            button.addTarget(self, action: #selector(didTapCapacityButton(sender:)), for: .touchUpInside)
            capacityButtons.append(button)
        }
        
        capacityButtons.first?.isSelected = true
        let capacityButtonHStack = UIStackView(arrangedSubviews: capacityButtons,
                                               axis: .horizontal,
                                               distribution: .equalSpacing,
                                               alignment: .center,
                                               spacing: 10)
        capacityButttonsScrollView.addSubview(capacityButtonHStack)

        capacityButtonHStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func makePriceLabel() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.backgroundColor = .clear
        return label
    }
    
    func makeAddToCartLabel() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.backgroundColor = .clear
        label.text = "Add to Cart"
        return label
    }
    
    func makeAddToCartView() -> UIView {
        let titleLabel = makeAddToCartLabel()
        
        let view = UIView()
        view.backgroundColor = UIColor(named: "AccentColor")
        view.layer.cornerRadius = 10
        
        let HStack = UIStackView(arrangedSubviews: [titleLabel, priceLabel], axis: .horizontal)
        
        view.addSubview(HStack)

        HStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.bottom.equalToSuperview()
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapAddToCart))
        view.addGestureRecognizer(tapGesture)
        
        containerView.addSubview(view)
        
        view.snp.makeConstraints { make in
            make.top.equalTo(colorButtonsScrollView.snp.bottom).offset(height*0.54*0.06)
            make.bottom.equalToSuperview().inset(height*0.54*0.08)
            make.leading.trailing.equalToSuperview().inset(width*0.07)
        }
        return view
    }
    
}
