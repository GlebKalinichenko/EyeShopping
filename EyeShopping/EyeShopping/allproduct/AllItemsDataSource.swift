//
//  AllItemsDataSource.swift
//  EyeShopping
//
//  Created by Gleb Kalinichenko on 18.05.18.
//  Copyright © 2018 Gleb Kalinichenko. All rights reserved.
//

import Foundation
import Alamofire

class AllItemsDataSource {
    
    func fetchItems(offset: Int, limit: Int,     callback: @escaping ([Item]) -> Void){
        var arrItems = [Item]()
        arrItems.append(Item(name: "Item 1", shop: "Shop 1"))
        arrItems.append(Item(name: "Item 2", shop: "Shop 2"))
        arrItems.append(Item(name: "Item 3", shop: "Shop 3"))
        callback(arrItems)
        /*Alamofire.request("http://localhost:3000/login/item/items", method: .get).responseJSON { response in
            
            if let json = response.result.value {}
            
            for itemJson in response as! [Item] {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: itemJson, options: .prettyPrinted)
                    let reqJSONStr = String(data: jsonData, encoding: .utf8)
                    let data = reqJSONStr?.data(using: .utf8)
                    let jsonDecoder = JSONDecoder()
                    let item = try jsonDecoder.decode(Item.self, from: data!)
                    arrItems.append(item)
                }
                catch {
                    
                }
            }
            
            callback(arrItems)
        }*/
    }
}
