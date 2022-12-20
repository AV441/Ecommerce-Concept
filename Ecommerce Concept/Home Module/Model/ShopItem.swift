//
//  HotSale.swift
//  Ecommerce Concept
//
//  Created by Андрей on 10.12.2022.
//

import Foundation

struct ShopItem: Decodable {
    let hotSales: [HotSaleItem]
    let bestSellers: [BestSellerItem]
    
    enum CodingKeys: String, CodingKey {
        case hotSales = "home_store"
        case bestSellers = "best_seller"
    }
}
