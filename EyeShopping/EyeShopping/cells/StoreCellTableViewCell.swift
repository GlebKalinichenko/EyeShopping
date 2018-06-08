//
//  StoreCellTableViewCell.swift
//  EyeShopping
//
//  Created by Gleb Kalinichenko on 08.06.2018.
//  Copyright © 2018 Gleb Kalinichenko. All rights reserved.
//

import UIKit

class StoreCellTableViewCell: UITableViewCell {
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var addressLine: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
