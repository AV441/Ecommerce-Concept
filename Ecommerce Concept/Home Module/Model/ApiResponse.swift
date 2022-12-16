//
//  HotSale.swift
//  Ecommerce Concept
//
//  Created by Андрей on 10.12.2022.
//

import Foundation

struct ApiResponse: Decodable {
    let hotSales: [HotSaleItem]
    let bestSellers: [BestSellerItem]
    
    enum CodingKeys: String, CodingKey {
        case hotSales = "home_store"
        case bestSellers = "best_seller"
    }
}

struct HotSaleItem: Decodable {
    let id: Int
    let isNew: Bool?
    let title: String
    let subtitle: String
    let pictureURL: String
    let isBuy: Bool
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case isNew = "is_new"
        case title = "title"
        case subtitle = "subtitle"
        case pictureURL = "picture"
        case isBuy = "is_buy"
    }
}

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
