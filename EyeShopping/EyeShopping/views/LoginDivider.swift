//
//  LoginDivider.swift
//  EyeShopping
//
//  Created by Gleb Kalinichenko on 14.02.18.
//  Copyright © 2018 Gleb Kalinichenko. All rights reserved.
//

import UIKit

class LoginDivider: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        guard let backgroundColor = self.backgroundColor?.cgColor else { return }
        self.layer.borderColor = backgroundColor
        self.layer.borderWidth = (1.0 / UIScreen.main.scale) / 2;
        self.backgroundColor = UIColor.clear
    }


}
