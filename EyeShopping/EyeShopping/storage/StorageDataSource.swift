//
//  StorageDataSource.swift
//  EyeShopping
//
//  Created by Gleb Kalinichenko on 18.05.18.
//  Copyright © 2018 Gleb Kalinichenko. All rights reserved.
//

import Foundation
import Alamofire

class StorageDataSource {
    
    func fetchStores(offset: Int, limit: Int, callback: @escaping ([Store]) -> Void){
        var arrStores = [Store]()
        arrStores.append(Store(storeName: "Store1", addressLine1: "Taganrog"))
        arrStores.append(Store(storeName: "Store2", addressLine1: "Taganrog"))
        arrStores.append(Store(storeName: "Store3", addressLine1: "Taganrog"))
        callback(arrStores)
        /*Alamofire.request("http://localhost:3000/login/store/stores", method: .get).responseJSON { response in
            
            if let json = response.result.value {}
            
            for storeJson in response as! [Store] {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: storeJson, options: .prettyPrinted)
                    let reqJSONStr = String(data: jsonData, encoding: .utf8)
                    let data = reqJSONStr?.data(using: .utf8)
                    let jsonDecoder = JSONDecoder()
                    let store = try jsonDecoder.decode(Store.self, from: data!)
                    arrStores.append(store)
                }
                catch {
                    
                }
            }
            
            callback(arrStores)
        }*/
    }
}
