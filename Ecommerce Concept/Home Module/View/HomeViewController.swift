//
//  ViewController.swift
//  Ecommerce Concept
//
//  Created by Андрей on 09.12.2022.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private var homeView: HomeView!
    
    public var viewModel: HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureView()
        bindViewModel()
    }
    
    private func configureView() {
        homeView = HomeView()
        homeView.frame = view.bounds
        homeView.collectionView.dataSource = self
        homeView.collectionView.delegate = self
        view.addSubview(homeView)
        
        homeView.cartButton.addTarget(self, action: #selector(didTapCartButton), for: .touchUpInside)
    }
    
    private func configureNavigationBar() {
        navigationItem.titleView = UIImageView(image: UIImage(named: "TitleView"))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icFilter"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didTapFilterButton))
    }
    
    @objc
    private func didTapFilterButton() {
        viewModel.coordinator.showFilters()
    }
    
    @objc
    private func didTapCartButton() {
        viewModel.coordinator.showCart()
    }
    
    private func bindViewModel() {
        viewModel.updateCollectionView = { [unowned self] in
            self.homeView.collectionView.reloadData()
        }
        
        viewModel.updateCategoryItem = { [unowned self] indexPathesOfChangedItems in
            self.homeView.collectionView.reloadItems(at: indexPathesOfChangedItems)
        }
        
        viewModel.updateBestsellerItem = { [unowned self] indexPath in
            self.homeView.collectionView.reloadItems(at: [indexPath])
        }
    }

}

// UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = HomeScreenSection.allCases[section]
        
        switch section {
            
        case .selectCategory:
            return viewModel.categories.count
        case .search:
            return 1
        case .hotSales:
            return viewModel.hotSalesItems.count
        case .bestSeller:
            return viewModel.bestSellersItems.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = HomeScreenSection.allCases[indexPath.section]

        switch section {
            
        case .selectCategory:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.id, for: indexPath) as! CategoryCollectionViewCell
            let categoryName = viewModel.categories[indexPath.item].rawValue
            let isSelected = viewModel.indexOfSelectedCategory == indexPath
            cell.configure(with: categoryName, isSelected: isSelected)
            return cell
        case .search:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.id, for: indexPath) as! SearchCollectionViewCell
            return cell
        case .hotSales:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotSalesCollectionViewCell.id, for: indexPath) as! HotSalesCollectionViewCell
            let item = viewModel.hotSalesItems[indexPath.item]
            cell.configure(withItem: item)
            return cell
        case .bestSeller:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BestSellerCollectionViewCell.id, for: indexPath) as! BestSellerCollectionViewCell
            let item = viewModel.bestSellersItems[indexPath.item]
            cell.configure(withItem: item)
            cell.delegate = self
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let section = HomeScreenSection.allCases[indexPath.section]
        
        switch section {
        
        case .selectCategory:
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionHeaderView.id, for: indexPath) as! CollectionHeaderView
            sectionHeader.titleLabel.text = section.rawValue
            return sectionHeader
        case .search:
            return UICollectionReusableView()
        case .hotSales:
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionHeaderView.id, for: indexPath) as! CollectionHeaderView
            sectionHeader.titleLabel.text = section.rawValue
            return sectionHeader
        case .bestSeller:
            let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionHeaderView.id, for: indexPath) as! CollectionHeaderView
            sectionHeader.titleLabel.text = section.rawValue
            return sectionHeader
        }
    }
    
}

// UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = viewModel.sections[indexPath.section]
        
        switch section {
        case .selectCategory:
            viewModel.indexOfSelectedCategory = indexPath
        case .search:
            break
        case .hotSales:
            viewModel.coordinator.showDetails()
        case .bestSeller:
            viewModel.coordinator.showDetails()
        }
    }
    
}

// BestSellerCellDelegate
extension HomeViewController: BestSellerCellDelegate {
    
    func likeButtonTapped(on item: BestSellerItem) {
        viewModel.changeFavoriteStatus(forItem: item)
    }
    
}
