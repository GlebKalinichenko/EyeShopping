//
//  Item.swift
//  EyeShopping
//
//  Created by Gleb Kalinichenko on 18.05.18.
//  Copyright © 2018 Gleb Kalinichenko. All rights reserved.
//

import Foundation

class Item: Codable {
    var name: String
    var shop: String
    var type = 2
    
    init(name: String, shop: String) {
        self.name = name
        self.shop = shop
    }
}
