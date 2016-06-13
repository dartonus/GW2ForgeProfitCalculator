//
//  CategoryHandler.swift
//  GW2CraftProfit
//
//  Created by Callum Grant on 5/2/16.
//  Copyright © 2016 Callum Grant. All rights reserved.
//

import UIKit

//Class to handle supported Categories, listing a dictionary of ID arrays, keyed by Category Name.
class CategoryHandler{
    let categories: [String: [Int]] = ["Siege": [21263, 21260, 21261, 21262, 21264, 74592, 21259], "Material Promotion": [24295, 24358, 24351, 24357, 24289, 24300, 24283], "Lodestone Promotion": [24310, 24315, 24320, 24325, 24330, 24340, 24305]]
    
    //Returns a list of the Categories.
    func getCategories() -> [String]{
        var returnArray = [String]()
        for categoryName in categories.keys{
            returnArray.append(categoryName)
        }
        return returnArray
    }
    
    //Returns the ID array for the given Category.
    func getIDs(categoryName: String) -> [Int]{
        return self.categories[categoryName]!
    }
}