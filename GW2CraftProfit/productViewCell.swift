//
//  productViewCell.swift
//  GW2CraftProfit
//
//  Created by Callum Grant on 4/24/16.
//  Copyright © 2016 Callum Grant. All rights reserved.
//

import UIKit

class productViewCell: UITableViewCell {
    @IBOutlet weak var productItemLabel: UILabel!
    @IBOutlet weak var productProfitLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
