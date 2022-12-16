//
//  DetailsViewModel.swift
//  Ecommerce Concept
//
//  Created by Андрей on 12.12.2022.
//

import Foundation

final class DetailsViewModel {
    
    var coordinator: Coordinator!
    var networkManager: NetworkManager!
    var detailsData: PhoneDetails?
    var updateView: () -> Void = {}
    var updateCartBadge: () -> Void = {}

    init(coordinator: Coordinator, networkManager: NetworkManager) {
        self.coordinator = coordinator
        self.networkManager = networkManager
        requestData()
    }
    
    func requestData() {
        networkManager.requestDetailsScreenData { [unowned self] result in
            switch result {
                
            case .success(let data):
                self.detailsData = data
                self.updateView()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func addToCart(item: PhoneDetails?) {
        // do something with chosen item
        updateCartBadge()
    }
}
