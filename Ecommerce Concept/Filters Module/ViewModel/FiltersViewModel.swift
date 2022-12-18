//
//  FiltersViewModel.swift
//  Ecommerce Concept
//
//  Created by Андрей on 12.12.2022.
//

import Foundation

protocol FiltersViewModelProtocol {
    var brands: [String] { get }
    var selectedBrand: String { get }
    var minPrice: Double { get }
    var maxPrice: Double { get }
    
    var updateBrand: () -> Void { get set }
    var updatePrice: () -> Void { get set }
    
    func cancelFilters()
    func applyFilters()
    func selectBrand(forIndex index: Int)
    func setMinPrice(_ value: Double)
    func setMaxPrice(_ value: Double)
}

final class FiltersViewModel: FiltersViewModelProtocol {
    var minPrice: Double = UserDefaults.standard.value(forKey: "minPrice") as? Double ?? 0 {
        didSet {
            UserDefaults.standard.set(minPrice, forKey: "minPrice")
        }
    }
    var maxPrice: Double = UserDefaults.standard.value(forKey: "maxPrice") as? Double ?? 10000 {
        didSet {
            UserDefaults.standard.set(maxPrice, forKey: "maxPrice")
        }
    }
    
    var selectedBrand: String = UserDefaults.standard.value(forKey: "selectedBrand") as? String ?? "All" {
        didSet {
            UserDefaults.standard.set(selectedBrand, forKey: "selectedBrand")
        }
    }
    
    var updatePrice: () -> Void = {}
    var updateBrand: () -> Void = {}
    
    private let filters = Filter()
    
    var brands: [String] {
        filters.brands
    }

    private var coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func cancelFilters() {
        coordinator.closeFilters()
    }
    
    func applyFilters() {
        coordinator.closeFilters()
    }
    
    func selectBrand(forIndex index: Int) {
        selectedBrand = brands[index]
        updateBrand()
    }
    
    func setMinPrice(_ value: Double) {
        minPrice = value
    }
    
    func setMaxPrice(_ value: Double) {
        maxPrice = value
    }
    
}
