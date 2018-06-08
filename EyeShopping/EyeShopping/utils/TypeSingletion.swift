//
//  TypeSingletion.swift
//  EyeShopping
//
//  Created by Gleb Kalinichenko on 08.06.2018.
//  Copyright © 2018 Gleb Kalinichenko. All rights reserved.
//

import Foundation

class TypeSingletion {
    var type = 1
    
    static let sharedInstance: TypeSingletion = TypeSingletion()
}
