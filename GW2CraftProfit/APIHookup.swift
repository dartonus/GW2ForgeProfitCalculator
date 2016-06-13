//
//  APIHookup.swift
//  GW2CraftProfit
//
//  Created by Callum Grant on 4/10/16.
//  Copyright © 2016 Callum Grant. All rights reserved.
//

import UIKit

class APIHookup{
    //MARK : API Hookup class
    
    
    //Method to find an object's current Buy Order price.
    //Because instantaneous selling fulfills the highest Buy Order, we thus check the "buys" parameter.
    func getSellNow(itemid: Int) -> Int {
        let semaphore = dispatch_semaphore_create(0);
        var value = 0
        var callURL = "https://api.guildwars2.com/v2/commerce/prices/"
        callURL += String(itemid)
        let requestURL: NSURL = NSURL(string: callURL)!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest){
            (data, response, error) -> Void in
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            //If our Request went through correctly, we serialize the received JSON so we can use it.
            if(statusCode == 200){
                do{
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
                    if let buys = json["buys"] as? [String: AnyObject]{
                        if let price = buys["unit_price"] as? Int{
                            value = price
                            dispatch_semaphore_signal(semaphore)
                        }
                    }
                }catch{
                    print("Error with JSON: \(error)")
                }
            }
        }
        if(itemid == 20798 || itemid == 20796 || itemid == 20799){
            //Siege Masters Guide, Philosopher's Stone, and Mystic Crystal.
            //These items are untradable and acquired for Spirit Shards, so they do not have a coin value.
            return 0
        }
        task.resume()
        //We need to wait until value is defined to return value, so we wait for the signal from the request thread.
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
        return value
    }
    
    //Similar to above, but find Sell Orders to get the instantaneous purchase price.
    func getBuyNow(itemid: Int) -> Int {
        let semaphore = dispatch_semaphore_create(0);
        var value = 0
        var callURL = "https://api.guildwars2.com/v2/commerce/prices/"
        callURL += String(itemid)
        let requestURL: NSURL = NSURL(string: callURL)!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest){
            (data, response, error) -> Void in
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            if(statusCode == 200){
                do{
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
                    if let sells = json["sells"] as? [String: AnyObject]{
                        if let price = sells["unit_price"] as? Int{
                            value = price
                            dispatch_semaphore_signal(semaphore)
                        }
                    }
                }catch{
                    print("Error with JSON: \(error)")
                }
            }
        }
        if(itemid == 20798 || itemid == 20796 || itemid == 20799){
            //Siege Masters Guide, Philosopher's Stone, and Mystic Crystal.
            //These items are untradable and acquired for Spirit Shards, so they do not have a coin value.
            return 0
        }
        if(itemid == 19663){
            //Elonian Wine sells for 25s4c from Miyani by the Mystic Forge.
            //It is impossible to sell on the TP for lower than merchant price + 18%.
            //Thus, it will always be cheapest to buy Elonian Wine from Miyani and we don't have to find its TP price.
            return 2504
        }
        task.resume()
        //Wait for value to be defined before returning it.
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
        return value
    }
}