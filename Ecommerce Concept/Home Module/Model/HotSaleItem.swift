//
//  HotSaleItem.swift
//  Ecommerce Concept
//
//  Created by Андрей on 20.12.2022.
//

import Foundation

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
