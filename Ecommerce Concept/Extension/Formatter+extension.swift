//
//  Formatter+extension.swift
//  Ecommerce Concept
//
//  Created by Андрей on 16.12.2022.
//

import Foundation

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        return formatter
    }()
}
