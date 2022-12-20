//
//  PhoneDetails.swift
//  Ecommerce Concept
//
//  Created by Андрей on 12.12.2022.
//

import Foundation

struct PhoneDetails: Decodable {
    let cpu, camera, sd, ssd, title: String
    let capacity, color: [String]
    let id: String
    let images: [String]
    var isFavorites: Bool
    let price: Int
    let rating: Double

    enum CodingKeys: String, CodingKey {
        case cpu = "CPU"
        case camera, capacity, color, id, images, isFavorites, price, rating, sd, ssd, title
    }
}
