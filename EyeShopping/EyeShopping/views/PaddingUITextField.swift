//
//  PaddingUITextField.swift
//  EyeShopping
//
//  Created by Gleb Kalinichenko on 14.02.18.
//  Copyright © 2018 Gleb Kalinichenko. All rights reserved.
//

import UIKit

class PaddingUITextField: UITextField {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds,
                                     UIEdgeInsetsMake(20, 20, 20, 20))
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds,
                                     UIEdgeInsetsMake(20, 20, 20, 20))
    }
    
}
