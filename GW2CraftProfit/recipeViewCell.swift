//
//  recipeViewCell.swift
//  GW2CraftProfit
//
//  Created by Callum Grant on 4/24/16.
//  Copyright © 2016 Callum Grant. All rights reserved.
//

import UIKit

class recipeViewCell: UITableViewCell {
    @IBOutlet weak var ingredientNameLabel: UILabel!
    @IBOutlet weak var ingredientQuantityLabel: UILabel!
    @IBOutlet weak var ingredientValueLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
