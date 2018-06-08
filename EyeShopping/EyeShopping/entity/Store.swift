//
//  Store.swift
//  EyeShopping
//
//  Created by Gleb Kalinichenko on 18.05.18.
//  Copyright © 2018 Gleb Kalinichenko. All rights reserved.
//

import Foundation

class Store: Codable {
    var storeName: String
    var addressLine1: String
    
    init(storeName: String, addressLine1: String) {
        self.storeName = storeName
        self.addressLine1 = addressLine1
    }
}
