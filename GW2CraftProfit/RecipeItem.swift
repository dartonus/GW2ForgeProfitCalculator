//
//  RecipeItem.swift
//  GW2CraftProfit
//
//  Created by Callum Grant on 5/2/16.
//  Copyright © 2016 Callum Grant. All rights reserved.
//

import UIKit

//Class to handle items used in a recipe.
class RecipeItem{
    //MARK : RecipeItem Properties
    var itemid: Int     //ID of the item.
    var quantity: Int   //Quantity used.
    var value: Int      //Instant Buy Price on the TP.
    
    //Our initializer just needs ID and Quantity, we can grab the value from our ID using the API.
    init(id: Int, quantity: Int){
        self.itemid = id
        self.quantity = quantity
        let hookup = APIHookup()
        self.value = hookup.getBuyNow(id)
    }
    
    //Helper to return the ID
    func getID() -> Int {
        return self.itemid
    }
    
    //Helper to return the quantity used.
    func getQuantity() -> Int {
        return self.quantity
    }
    
    //Helper to return the TP buy price.
    func getValue() -> Int {
        return self.value
    }
    
    //Function to print all stored data to the console, was used for debugging purposes.
    func printInfo(){
        print("ID: ", itemid, ", Quantity", quantity, ", value", value)
    }
}
