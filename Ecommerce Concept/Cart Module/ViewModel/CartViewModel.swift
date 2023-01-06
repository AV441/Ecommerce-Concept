//
//  CartViewModel.swift
//  Ecommerce Concept
//
//  Created by Андрей on 16.12.2022.
//

import Foundation

protocol CartViewModelProtocol {
    // Outputs
    var basketItems: Observable<[BasketItem]> { get }
    var totalPrice: Observable<Int> { get }
    var deliveryPrice: Observable<String> { get }

    // Inputs
    func addOneItem(withID id: Int)
    func removeOneItem(withID id: Int)
    func removeAllItems(withID id: Int)
    func backToPreviousScreen()
    func checkoutOrder()
 }

final class CartViewModel {
    var basketItems: Observable<[BasketItem]> = Observable([])
    var totalPrice: Observable<Int> = Observable(0)
    var deliveryPrice: Observable<String> = Observable("")
    
    private var networkManager: NetworkManager!
    private var coordinator: Coordinator!

    init(coordinator: Coordinator, networkManager: NetworkManager) {
        self.coordinator = coordinator
        self.networkManager = networkManager
        requestData()
    }

    private func requestData() {
        networkManager.requestCartScreenData { [weak self] result in
            switch result {

            case .success(let apiResponse):
                self?.basketItems.value = apiResponse.basket
                self?.totalPrice.value = apiResponse.total
                self?.deliveryPrice.value = apiResponse.delivery
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func addOneItem(withID id: Int) {
        guard var item = basketItems.value.first(where: {$0.id == id}),
              let index = basketItems.value.firstIndex(where: {$0.id == id}) else {
            return
        }
        
        var count = item.count ?? 1
        count += 1
        item.count = count
        basketItems.value[index] = item
        totalPrice.value += item.price
    }
    
    func removeOneItem(withID id: Int) {
        guard var item = basketItems.value.first(where: {$0.id == id}),
              let index = basketItems.value.firstIndex(where: {$0.id == id}) else {
            return
        }
        
        var count = item.count ?? 1
        if count > 1 {
            count -= 1
            item.count = count
            basketItems.value[index] = item
            totalPrice.value -= item.price
        }
    }
    
    func removeAllItems(withID id: Int) {
        guard let item = basketItems.value.first(where: {$0.id == id}) else { return }
        basketItems.value.removeAll(where: {$0.id == id})
        let count = item.count ?? 1
        totalPrice.value -= item.price*count
    }
    
    func backToPreviousScreen() {
        coordinator.popViewController()
    }
    
    func checkoutOrder() {
        // networkManager.postOrder()
        NotificationCenter.default.post(name: NSNotification.Name("clearCart"), object: nil)
        UserDefaults.standard.set(0, forKey: "badgeValue")
        coordinator.backToMain()
    }
    
}



