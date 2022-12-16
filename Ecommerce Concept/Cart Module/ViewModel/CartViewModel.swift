//
//  CartViewModel.swift
//  Ecommerce Concept
//
//  Created by Андрей on 16.12.2022.
//

import Foundation

final class CartViewModel {
    
    private var networkManager: NetworkManager!
    var coordinator: Coordinator!

    var cartItem: CartItem?
    var basket: [BasketItem] = []
    var totalPrice: Int = 0
    
    var updateView: () -> Void = {}
    
    init(networkManager: NetworkManager, coordinator: Coordinator) {
        self.networkManager = networkManager
        self.coordinator = coordinator
        requestData()
    }
    
    private func requestData() {
        networkManager.requestCartScreenData { result in
            switch result {

            case .success(let apiResponse):
                self.cartItem = apiResponse
                self.basket = apiResponse.basket
                self.totalPrice = apiResponse.total
                self.updateView()
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func addOneItem(withID id: Int) {
        guard var item = basket.first(where: {$0.id == id}),
              let index = basket.firstIndex(where: {$0.id == id}) else {
            return
        }
        
        var count = item.count ?? 1
        count += 1
        item.count = count
        basket[index] = item
        totalPrice += item.price
        updateView()
    }
    
    func removeOneItem(withID id: Int) {
        guard var item = basket.first(where: {$0.id == id}),
              let index = basket.firstIndex(where: {$0.id == id}) else {
            return
        }
        
        var count = item.count ?? 1
        if count > 1 {
            count -= 1
            item.count = count
            basket[index] = item
            totalPrice -= item.price
            updateView()
        }
    }
    
    func deleteAllItems(withID id: Int) {
        guard let item = basket.first(where: {$0.id == id}) else { return }
        basket.removeAll(where: {$0.id == id})
        let count = item.count ?? 1
        totalPrice -= item.price*count
        updateView()
    }
    
}
