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
    var badgeCount: Observable<Int> { get }
    
    var updateCollectionView: () -> Void { get set }
    var updateCategoryItems: ([IndexPath]) -> Void { get set }
    var updateBestsellerItem: (IndexPath) -> Void { get set }
    
    // Inputs
    func selectCategory(at indexPath: IndexPath)
    func selectItem(at indexPath: IndexPath)
    func favouriteButtonTapped(at indexPath: IndexPath)
    func filtersButtonTapped()
    func cartButtonTapped()
    func buyNow()
}

final class HomeViewModel: HomeViewModelProtocol {
    private var networkManager: NetworkManager
    private var coordinator: Coordinator
    
    // Outputs
    var sections = HomeScreenSection.allCases
    var categories = ShopCategory.allCases
    var hotSalesItems = [HotSaleItem]()
    var bestSellersItems = [BestSellerItem]()
    var badgeCount: Observable<Int> = Observable(UserDefaults.standard.value(forKey: "badgeValue") as? Int ?? 0)
    
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
        NotificationCenter.default.addObserver(self, selector: #selector(addBadge), name: NSNotification.Name(rawValue: "addToCart"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(removeBadge), name: NSNotification.Name(rawValue: "clearCart"), object: nil)
    }
    
    @objc
    private func addBadge() {
        badgeCount.value = UserDefaults.standard.value(forKey: "badgeValue") as? Int ?? 0
    }
    
    @objc
    private func removeBadge() {
        badgeCount.value = 0
    }
    
    private func requestData() {
        networkManager.requestHomeScreenData { [weak self] result in
            switch result {

            case .success(let shopItems):
                self?.hotSalesItems = shopItems.hotSales
                self?.bestSellersItems = shopItems.bestSellers
                self?.updateCollectionView()
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
    
    func buyNow() {
        coordinator.showCart()
    }
    
}
