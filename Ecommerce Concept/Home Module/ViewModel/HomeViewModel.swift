//
//  HomeViewModel.swift
//  Ecommerce Concept
//
//  Created by Андрей on 10.12.2022.
//

import Foundation

enum HomeScreenSection: String, CaseIterable {
    case selectCategory = "Select Category"
    case search
    case hotSales = "Hot Sales"
    case bestSeller = "Best Sellers"
}

enum Category: String, CaseIterable {
    case phones = "Phones"
    case computers = "Computers"
    case health = "Health"
    case books = "Books"
    case accessories = "Accessories"
}

final class HomeViewModel {
    
    private var networkManager: NetworkManager
    private var coordinator: Coordinator
    
    let sections = HomeScreenSection.allCases
    let categories = Category.allCases
    
    var hotSalesItems = [HotSaleItem]()
    var bestSellersItems = [BestSellerItem]()
    
    var updateCollectionView: () -> Void = {}
    var updateCategoryItem: (([IndexPath]) -> Void)?
    var updateBestsellerItem: ((IndexPath) -> Void)?
    
    var indexOfSelectedCategory: IndexPath = IndexPath(item: 0, section: 0) {
        didSet {
            updateCategoryItem?([oldValue, indexOfSelectedCategory])
        }
    }
    
    init(coordinator: Coordinator, networkManager: NetworkManager) {
        self.coordinator = coordinator
        self.networkManager = networkManager
        requestData()
    }
    
    func requestData() {
        networkManager.requestHomeScreenData { result in
            switch result {

            case .success(let apiResponse):
                self.hotSalesItems = apiResponse.hotSales
                self.bestSellersItems = apiResponse.bestSellers
                self.updateCollectionView()
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func changeFavoriteStatus(forItem item: BestSellerItem) {
        if let index = bestSellersItems.firstIndex(where: {$0.id == item.id}) {
            bestSellersItems[index].isFavorites.toggle()
            updateBestsellerItem?(IndexPath(item: index, section: 3))
        }
    }
    
    func showDetails() {
        coordinator.showDetails()
    }
    
    func showFilters() {
        coordinator.showFilters()
    }
    
    func showCart() {
        coordinator.showCart()
    }
    
}
