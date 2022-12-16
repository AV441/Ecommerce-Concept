//
//  FiltersViewModel.swift
//  Ecommerce Concept
//
//  Created by Андрей on 12.12.2022.
//

import Foundation

enum FilterSection: String, CaseIterable {
    case brand = "Brand"
    case price = "Price"
    case size = "Size"
}

final class FiltersViewModel {
    
    var coordinator: Coordinator!

    let sections = FilterSection.allCases
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
}
