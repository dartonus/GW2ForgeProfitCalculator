//
//  displayHelper.swift
//  GW2CraftProfit
//
//  Created by Callum Grant on 5/2/16.
//  Copyright © 2016 Callum Grant. All rights reserved.
//

import UIKit

//Class to handle prettying up the data to display in the App.
class DisplayHelper{
    
    //Values are returned from the GW2 API in coins, or raw copper value.
    //In-game, your money is automatically parsed into gold, silver, and copper.
    //Do this parsing to ease readability of the profits/prices.
    func goldValue(value: Int) -> String{
        var workingValue = value
        var copperValue = 0
        var silverValue = 0
        var goldValue = 0
        var valueString = ""
        if(workingValue < 0){
            valueString = "-"
            workingValue = abs(workingValue)
        }
        //1g = 100s, 1s = 100c
        copperValue = workingValue % 100
        workingValue = (workingValue - copperValue) / 100
        if(workingValue > 0){
            silverValue = workingValue % 100
            workingValue = (workingValue - silverValue) / 100
            if(workingValue > 0){
                goldValue = workingValue
            }
        }
        //Only add values that we actually have - we don't need to say that we're gaining 0g 6s, just that we're getting 6s.
        if(goldValue > 0){
            valueString = valueString + String(goldValue) + "g"
        }
        if(silverValue > 0){
            valueString = valueString + String(silverValue) + "s"
        }
        if(copperValue > 0){
            valueString = valueString + String(copperValue) + "c"
        }
        return valueString
    }
    
    //Get the name from the ID. This could be replaced by a call to the items endpoint to get the Name value, but that'll add a bunch more API calls and I'm not using too many extra items.
    //Thus, I'm using this for now.
    func nameFromID(itemid: Int) -> String{
        //Basic Materials
        if(itemid == 19663){
            return "Bottle of Elonian Wine"
        }
        if(itemid == 19700){
            return "Mithril Ore"
        }
        if(itemid == 19722){
            return "Elder Wood Log"
        }
        if(itemid == 20798){
            return "Siege Masters Guide"
        }
        if(itemid == 24277){
            return "Pile of Crystalline Dust"
        }
        if(itemid == 20796){
            return "Philosopher's Stone"
        }
        if(itemid == 20799){
            return "Mystic Crystal"
        }
        
        //MARK: Siege
        if(itemid == 21263){
            return "Superior Flame Ram Blueprints"
        }
        if(itemid == 21161){
            return "Flame Ram Blueprints"
        }
        if(itemid == 21260){
            return "Superior Arrow Cart Blueprints"
        }
        if(itemid == 21156){
            return "Arrow Cart Blueprints"
        }
        if(itemid == 21261){
            return "Superior Ballista Blueprints"
        }
        if(itemid == 21157){
            return "Ballista Blueprints"
        }
        if(itemid == 21262){
            return "Superior Catapult Blueprints"
        }
        if(itemid == 21158){
            return "Catapult Blueprints"
        }
        if(itemid == 21264){
            return "Superior Trebuchet Blueprints"
        }
        if(itemid == 21160){
            return "Trebuchet Blueprints"
        }
        if(itemid == 74592){
            return "Superior Shield Generator Blueprint"
        }
        if(itemid == 75311){
            return "Shield Generator Blueprint"
        }
        if(itemid == 21259){
            return "Omega Siege Golem Blueprints"
        }
        if(itemid == 21159){
            return "Alpha Siege Golem Blueprints"
        }
        
        //MARK: Fine Materials
        if(itemid == 24295){
            return "Vial of Powerful Blood"
        }
        if(itemid == 24294){
            return "Vial of Potent Blood"
        }
        if(itemid == 24358){
            return "Ancient Bone"
        }
        if(itemid == 24341){
            return "Large Bone"
        }
        if(itemid == 24351){
            return "Vicious Claw"
        }
        if(itemid == 24350){
            return "Large Claw"
        }
        if(itemid == 24357){
            return "Vicious Fang"
        }
        if(itemid == 24356){
            return "Large Fang"
        }
        if(itemid == 24289){
            return "Armored Scale"
        }
        if(itemid == 24288){
            return "Large Scale"
        }
        if(itemid == 24300){
            return "Elaborate Totem"
        }
        if(itemid == 24299){
            return "Intricate Totem"
        }
        if(itemid == 24283){
            return "Powerful Venom Sac"
        }
        if(itemid == 24282){
            return "Potent Venom Sac"
        }
        
        //MARK: Lodestones
        if(itemid == 24310){
            return "Onyx Lodestone"
        }
        if(itemid == 24309){
            return "Onyx Core"
        }
        if(itemid == 24315){
            return "Molten Lodestone"
        }
        if(itemid == 24314){
            return "Molten Core"
        }
        if(itemid == 24320){
            return "Glacial Lodestone"
        }
        if(itemid == 24319){
            return "Glacial Core"
        }
        if(itemid == 24325){
            return "Destroyer Lodestone"
        }
        if(itemid == 24324){
            return "Destroyer Core"
        }
        if(itemid == 24330){
            return "Crystal Lodestone"
        }
        if(itemid == 24329){
            return "Crystal Core"
        }
        if(itemid == 24340){
            return "Corrupted Lodestone"
        }
        if(itemid == 24339){
            return "Corrupted Core"
        }
        if(itemid == 24305){
            return "Charged Lodestone"
        }
        if(itemid == 24304){
            return "Charged Core"
        }
        
        return "Unknown"
    }
}
