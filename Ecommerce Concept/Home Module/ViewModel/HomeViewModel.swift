//
//  HomeViewModel.swift
//  Ecommerce Concept
//
//  Created by Андрей on 10.12.2022.
//

import Foundation

protocol HomeViewModelProtocol {
    // Outputs
    var sections: [HomeScreenSection] { get }
    var categories: [ShopCategory] { get }
    var hotSalesItems: [HotSaleItem] { get }
    var bestSellersItems: [BestSellerItem] { get }
    var indexOfSelectedCategory: IndexPath { get }
    
    var updateCollectionView: () -> Void { get set }
    var updateCategoryItems: ([IndexPath]) -> Void { get set }
    var updateBestsellerItem: (IndexPath) -> Void { get set }
    
    // Inputs
    func selectCategory(at indexPath: IndexPath)
    func selectItem(at indexPath: IndexPath)
    func favouriteButtonTapped(at indexPath: IndexPath)
    func filtersButtonTapped()
    func cartButtonTapped()
}

final class HomeViewModel: HomeViewModelProtocol {
    private var networkManager: NetworkManager
    private var coordinator: Coordinator
    
    // Outputs
    var sections = HomeScreenSection.allCases
    var categories = ShopCategory.allCases
    var hotSalesItems = [HotSaleItem]()
    var bestSellersItems = [BestSellerItem]()
    
    var updateCollectionView: () -> Void = {}
    var updateCategoryItems: ([IndexPath]) -> Void = { _ in }
    var updateBestsellerItem: (IndexPath) -> Void = { _ in }
    
    var indexOfSelectedCategory: IndexPath = IndexPath(item: 0, section: 0) {
        didSet {
            updateCategoryItems([oldValue, indexOfSelectedCategory])
        }
    }
    
    init(coordinator: Coordinator, networkManager: NetworkManager) {
        self.coordinator = coordinator
        self.networkManager = networkManager
        requestData()
    }
    
    private func requestData() {
        networkManager.requestHomeScreenData { result in
            switch result {

            case .success(let shopItems):
                self.hotSalesItems = shopItems.hotSales
                self.bestSellersItems = shopItems.bestSellers
                self.updateCollectionView()
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    // Inputs
    func selectCategory(at indexPath: IndexPath) {
        indexOfSelectedCategory = indexPath
    }
    
    func selectItem(at indexPath: IndexPath) {
        coordinator.showDetails()
    }
    
    func favouriteButtonTapped(at indexPath: IndexPath) {
        bestSellersItems[indexPath.item].isFavorites.toggle()
        updateBestsellerItem(indexPath)
    }
    
    func filtersButtonTapped() {
        coordinator.showFilters()
    }
    
    func cartButtonTapped() {
        coordinator.showCart()
    }
    
}
