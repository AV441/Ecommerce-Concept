//
//  Dymanic.swift
//  Ecommerce Concept
//
//  Created by Андрей on 17.12.2022.
//

import Foundation

class Observable<T> {
    
    typealias Listener = (T) -> Void
    
    private var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ listener: @escaping Listener) {
        self.listener = listener
//        listener(value)
    }
    
}
