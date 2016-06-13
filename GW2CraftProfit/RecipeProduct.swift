//
//  RecipeProduct.swift
//  GW2CraftProfit
//
//  Created by Callum Grant on 5/2/16.
//  Copyright © 2016 Callum Grant. All rights reserved.
//

import UIKit

class RecipeProduct{
    //MARK: RecipeProduct Properties
    var itemid: Int
    var value: Int
    var recipe: [RecipeItem]
    
    init(id: Int){
        let hookup = APIHookup()
        self.itemid = id
        self.value = hookup.getSellNow(id)
        self.recipe = []
        self.recipe = lookupRecipe(id)
    }
    
    //Unfortunately, Mystic Forge Recipes are not provided by the GW2 API.
    //As a result, this large function manually provides Mystic Forge recipes for select ids.
    //Any new products should have their Mystic Forge recipes added here.
    func lookupRecipe(itemid: Int) -> [RecipeItem]{
        var recipe = [RecipeItem]()
        //MARK: Superior Siege Blueprints
        if(itemid == 21263 || itemid == 21260 || itemid == 21261 || itemid == 21262 || itemid == 21264 || itemid == 74592 || itemid == 21259){
            var elderMithrilQuantity = 5    //Most siege only takes 5 Ore and Wood to promote.
            if(itemid == 21264 || itemid == 21259){ //Trebuchets and Golems take 10 Mithril Ore and Elder Wood Logs to promote.
                elderMithrilQuantity = 10
            }
            recipe.append(RecipeItem(id: 19700, quantity: elderMithrilQuantity))
            recipe.append(RecipeItem(id: 19722, quantity: elderMithrilQuantity))
            if(itemid == 21259){    //Omega Siege Golem uses 3 Siege Manuals instead of 1. Also handle adding the Alpha Siege Golem Blueprints in the required quantity.
                recipe.append(RecipeItem(id: 20798, quantity: 3))
                recipe.append(RecipeItem(id: 21159, quantity: 5))
            }else{
                recipe.append(RecipeItem(id: 20798, quantity: 1))
            }
            //Siege Blueprint Recipes do not have a pattern to how their IDs are related, so we cannot get the basic ID from the superior's ID.
            if(itemid == 21263){    //Flame Ram's Basic Blueprint
                recipe.append(RecipeItem(id: 21161, quantity: 2))
            }
            if(itemid == 21260){    //Arrow Cart's Basic Blueprint
                recipe.append(RecipeItem(id: 21156, quantity: 2))
            }
            if(itemid == 21261){    //Ballista's Basic Blueprint
                recipe.append(RecipeItem(id: 21157, quantity: 2))
            }
            if(itemid == 21262){    //Catapult's Basic Blueprint
                recipe.append(RecipeItem(id: 21158, quantity: 2))
            }
            if(itemid == 21264){    //Trebuchet's Basic Blueprint
                recipe.append(RecipeItem(id: 21160, quantity: 2))
            }
            if(itemid == 74592){    //Shield Generator's Basic Blueprint
                recipe.append(RecipeItem(id: 75311, quantity: 2))
            }
        }else if(itemid == 24295 || itemid == 24358 || itemid == 24351 || itemid == 24357 || itemid == 24289 || itemid == 24300 || itemid == 24283){
            //MARK: T6 Mat Promotion
            //This ugly set of If statements adds the t5 version of the material to the recipe.
            //T5 and T6 Bones have a weird ID gap we need to check for, but all others have their T5 with an ID of 1 less than the T6.
            if(itemid == 24358){
                recipe.append(RecipeItem(id: 24341, quantity: 50))
            }else{
                recipe.append(RecipeItem(id: itemid - 1, quantity: 50))
            }
            recipe.append(RecipeItem(id: itemid, quantity: 1))  //T6 mat
            recipe.append(RecipeItem(id: 24277, quantity: 5))   //Crystalline Dust
            recipe.append(RecipeItem(id: 20796, quantity: 5))   //Philosopher's Stone
        }else if(itemid == 24310 || itemid == 24315 || itemid == 24320 || itemid == 24325 || itemid == 24330 || itemid == 24340 || itemid == 24305){
            //MARK: Lodestone Promotion
            //Thankfully, all cores have an id one lower than their corresponding Lodestone, making this easy.
            recipe.append(RecipeItem(id: itemid - 1, quantity: 2))  //Core
            recipe.append(RecipeItem(id: 19663, quantity: 1))   //Elonian Wine
            recipe.append(RecipeItem(id: 24277, quantity: 1))   //Crystalline Dust
            recipe.append(RecipeItem(id: 20799, quantity: 1))   //Mystic Crystal
        }
        return recipe
    }
    
    //Helper Function to return the ID of the item produced by the Recipe.
    func getID() -> Int{
        return self.itemid
    }
    
    //Helper Function to return the Recipe for the Product.
    func getRecipe() -> [RecipeItem]{
        return self.recipe
    }
    
    //Calculate profit of a given product after AH fees are taken into account.
    func getProfit() -> Int{
        var netprofit = 0
        netprofit = self.value
        if(itemid == 24295 || itemid == 24358 || itemid == 24351 || itemid == 24357 || itemid == 24289 || itemid == 24300 || itemid == 24283){
            //Material Promotion has an output of 5-12, so we are taking the average.
            netprofit = netprofit * 17
            netprofit = netprofit / 2
        }
        //Auction House fees add up to 15%, so we grab 85% of our sell value.
        netprofit = (netprofit * 85)/100
        for item in recipe{
            netprofit -= (item.getValue() * item.getQuantity())
        }
        return netprofit
    }
    
    //Prints info stored in RecipeProduct to the console, was used for debugging purposes.
    func printInfo(){
        print("ID: ", itemid, ", Value: ", value, "Recipe info: ")
        for item in recipe{
            item.printInfo()
        }
    }
}
