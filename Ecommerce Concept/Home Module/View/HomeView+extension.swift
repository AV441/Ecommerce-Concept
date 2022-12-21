//
//  HomeView+extension.swift
//  Ecommerce Concept
//
//  Created by Андрей on 11.12.2022.
//

import UIKit
import SnapKit

extension HomeView {
    
    func makeCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeLayout())
        collectionView.backgroundColor = UIColor(named: "Background")
        
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.id)
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.id)
        collectionView.register(HotSalesCollectionViewCell.self, forCellWithReuseIdentifier: HotSalesCollectionViewCell.id)
        collectionView.register(BestSellerCollectionViewCell.self, forCellWithReuseIdentifier: BestSellerCollectionViewCell.id)
        
        collectionView.register(CollectionHeaderView.self, forSupplementaryViewOfKind: "sectionHeader", withReuseIdentifier: CollectionHeaderView.id)
        return collectionView
    }
    
    func makeLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutenvironmets in
            let section = HomeScreenSection.allCases[sectionIndex]
            
            let sectionHeaderSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(32))
            
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionHeaderSize,
                                                                            elementKind: "sectionHeader",
                                                                            alignment: .top)
            
            switch section {
                
            case .selectCategory:
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(70),
                                                      heightDimension: .absolute(93))
                
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(70),
                                                       heightDimension: .absolute(93))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                               subitem: item,
                                                               count: 1)
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 24,
                                                                leading: 25,
                                                                bottom: 35,
                                                                trailing: 27)
                section.interGroupSpacing = 20
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.supplementariesFollowContentInsets = false
                section.boundarySupplementaryItems = [sectionHeader]
                return section
                
            case .search:
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                      heightDimension: .estimated(34))
                
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .estimated(34))
                
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                             subitem: item,
                                                             count: 1)
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                                leading: 32,
                                                                bottom: 24,
                                                                trailing: 37)
                return section
                
            case .hotSales:
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                      heightDimension: .absolute(182))
                
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 21)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .absolute(182))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                               subitem: item,
                                                               count: 1)
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 8,
                                                                leading: 0,
                                                                bottom: 11,
                                                                trailing: 0)
                section.orthogonalScrollingBehavior = .groupPaging
                section.boundarySupplementaryItems = [sectionHeader]
                return section
                
            case .bestSeller:
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2),
                                                      heightDimension: .estimated(227))
                
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                       heightDimension: .estimated(227))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
                group.interItemSpacing = .fixed(14)
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 16,
                                                                leading: 15,
                                                                bottom: 48,
                                                                trailing: 21)
                section.interGroupSpacing = 14
                section.supplementariesFollowContentInsets = false
                section.boundarySupplementaryItems = [sectionHeader]
                return section
            }
        }
        return layout
    }
    
    func makeTabView() -> UIView {
        let tabView = UIView()
        tabView.layer.cornerRadius = 30
        tabView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        tabView.backgroundColor = UIColor(named: "Midnight")
       
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(explorerButton)
        stackView.addArrangedSubview(cartButton)
        stackView.addArrangedSubview(favoritesButton)
        stackView.addArrangedSubview(profileButton)
        
        tabView.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalTo(tabView)
            make.leading.trailing.equalTo(tabView).inset(68)
        }
        return tabView
    }
    
    func makeButton(title: String?, image: UIImage?) -> UIButton {
        let button = UIButton()
        button.setImage(image, for: .normal)
        button.setTitle(title, for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = UIFont(name: "MarkPro-Bold", size: 15)
        return button
    }
    
    func makeBadgeLabel() -> UILabel {
        let badgeSize: CGFloat = 18
        let badge = UILabel()
        badge.layer.cornerRadius = badgeSize / 2
        badge.layer.masksToBounds = true
        badge.backgroundColor = .systemRed
        badge.font = badge.font.withSize(12)
        badge.textColor = .white
        badge.textAlignment = .center
        
        cartButton.addSubview(badge)

        badge.snp.makeConstraints { make in
            make.centerX.equalTo(cartButton.snp.centerX).offset(10)
            make.centerY.equalTo(cartButton.snp.centerY).offset(-10)
            make.width.equalTo(badgeSize)
            make.height.equalTo(badgeSize)
        }
        return badge
    }
    
}
