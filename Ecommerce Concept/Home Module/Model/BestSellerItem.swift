//
//  BestSellerItem.swift
//  Ecommerce Concept
//
//  Created by Андрей on 20.12.2022.
//

import Foundation

struct BestSellerItem: Decodable {
    let id: Int
    var isFavorites: Bool
    let title: String
    let priceWithoutDiscount: Int
    let discountPrice: Int
    let pictureURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case isFavorites = "is_favorites"
        case title
        case priceWithoutDiscount = "price_without_discount"
        case discountPrice = "discount_price"
        case pictureURL = "picture"
    }
}
