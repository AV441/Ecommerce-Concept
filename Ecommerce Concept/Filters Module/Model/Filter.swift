//
//  FiltersModel.swift
//  Ecommerce Concept
//
//  Created by Андрей on 16.12.2022.
//

import Foundation

struct Filter {
    let brands: [String] = ["All", "Samsung", "Apple", "Xiaomi", "Motorola", "Huawei", "Nokia"]
    let minPrice: Int = 0
    let maxPrice: Int = 100000
}
