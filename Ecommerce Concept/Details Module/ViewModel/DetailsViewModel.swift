//
//  DetailsViewModel.swift
//  Ecommerce Concept
//
//  Created by Андрей on 12.12.2022.
//

import Foundation

protocol DetailsViewModelProtocol {
    // Outputs
    var detailsData: PhoneDetails? { get }
    var badgeCount: Observable<Int> { get }
    var selectedSection: Observable<DetailsSection> { get }
    var selectedColor: Observable<String> { get }
    var selectedCapacity: Observable<String> { get }
    var isFavoutite: Observable<Bool> { get }
    
    var updateView: () -> Void { get set }
    
    // Inputs
    func addToCart()
    func selectColor(for index: Int)
    func selectCapacity(for index: Int)
    func selectSection(for index: Int)
    func favouriteButtonTapped()
    func backButtonTapped()
    func cartButtonTapped()
}

final class DetailsViewModel: DetailsViewModelProtocol {
    private var coordinator: Coordinator
    private var networkManager: NetworkManager
    private let sections = DetailsSection.allCases
    
    // Outputs
    var detailsData: PhoneDetails?
    var badgeCount: Observable<Int> = Observable(UserDefaults.standard.value(forKey: "badgeValue") as? Int ?? 0)
    var selectedSection: Observable<DetailsSection> = Observable(.shop)
    var selectedColor: Observable<String> = Observable("")
    var selectedCapacity: Observable<String> = Observable("")
    var isFavoutite: Observable<Bool> = Observable(false)
    
    var updateView: () -> Void = {}

    init(coordinator: Coordinator, networkManager: NetworkManager) {
        self.coordinator = coordinator
        self.networkManager = networkManager
        requestData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(removeBadge), name: NSNotification.Name(rawValue: "clearCart"), object: nil)
    }
    
    private func requestData() {
        networkManager.requestDetailsScreenData { [unowned self] result in
            switch result {
                
            case .success(let data):
                self.detailsData = data
                self.selectedColor.value = data.color[0]
                self.selectedColor.value = data.capacity[0]
                self.isFavoutite.value = data.isFavorites
                self.updateView()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @objc
    private func removeBadge() {
        badgeCount.value = 0
        UserDefaults.standard.set(0, forKey: "badgeValue")
    }
    
    // Inputs
    func addToCart() {
        badgeCount.value += 1
        UserDefaults.standard.set(badgeCount.value, forKey: "badgeValue")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "addToCart"), object: nil)
        // TODO: send item details(model, selectedColor, selectedCapacity) to server
    }
    
    func backButtonTapped() {
        coordinator.popViewController()
    }
    
    func cartButtonTapped() {
        coordinator.showCart()
    }
    
    func selectSection(for index: Int) {
        selectedSection.value = sections[index]
    }
    
    func selectColor(for index: Int) {
        if let detailsData = detailsData {
            selectedColor.value = detailsData.color[index]
        }
    }
    
    func selectCapacity(for index: Int) {
        if let detailsData = detailsData {
            selectedCapacity.value = detailsData.capacity[index]
        }
    }
 
    func favouriteButtonTapped() {
        isFavoutite.value.toggle()
        // TODO: send changes to server
    }
}
