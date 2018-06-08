//
//  LoginDataSource.swift
//  EyeShopping
//
//  Created by Gleb Kalinichenko on 24.04.18.
//  Copyright © 2018 Gleb Kalinichenko. All rights reserved.
//

import Foundation
import Alamofire

class LoginDataSource {
    
    func login(firstName: String, lastName: String, email: String, password: String) {

        let parameters: Parameters = [
            "email": email,
            "password": password
        ]
        
        let req = Alamofire.request("http://localhost:3000/login/wallet/signIn", method: .post, parameters: parameters, encoding:  JSONEncoding.default).responseJSON { response in
            if let json = response.result.value {
                
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
        
        debugPrint(req)
    }
}
