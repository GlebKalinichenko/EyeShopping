//
//  File.swift
//  EyeShopping
//
//  Created by Gleb Kalinichenko on 18.05.18.
//  Copyright © 2018 Gleb Kalinichenko. All rights reserved.
//

import Foundation
import Alamofire

class ProductDataSource {
    
    func fetchItems(offset: Int, limit: Int, merchantId: CLong, callback: @escaping ([Item]) -> Void){
        var arrItems = [Item]()
        Alamofire.request("http://localhost:3000/login/item/itemsWithStore/\(merchantId)", method: .get).responseJSON { response in
            
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
            
            //callback(arrItems)
        }
    }
}

