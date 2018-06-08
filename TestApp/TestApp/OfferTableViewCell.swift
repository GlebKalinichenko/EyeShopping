//
//  OfferTableViewCell.swift
//  TestApp
//
//  Created by Gleb Kalinichenko on 08.03.18.
//  Copyright © 2018 Gleb Kalinichenko. All rights reserved.
//

import UIKit

class OfferTableViewCell: UITableViewCell {
    @IBOutlet var name_offer: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
