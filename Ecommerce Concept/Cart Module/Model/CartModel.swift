//
//  CartModel.swift
//  Ecommerce Concept
//
//  Created by Андрей on 16.12.2022.
//

import Foundation

struct CartItem: Decodable {
    let basket: [BasketItem]
    let delivery, id: String
    let total: Int
}

struct BasketItem: Decodable {
    let id: Int
    let images: String
    let price: Int
    let title: String
    var count: Int?
}

