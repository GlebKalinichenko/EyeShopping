//
//  StringExtensions.swift
//  EyeShopping
//
//  Created by Gleb Kalinichenko on 16.02.18.
//  Copyright © 2018 Gleb Kalinichenko. All rights reserved.
//

import UIKit

extension String {
    func validateEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with:self)
    }
    
    func validatePassword() -> Bool {
        return self.count > 0
    }

}
