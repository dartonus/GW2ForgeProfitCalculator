//
//  recipeViewController.swift
//  GW2CraftProfit
//
//  Created by Callum Grant on 4/24/16.
//  Copyright © 2016 Callum Grant. All rights reserved.
//

import UIKit

class recipeViewController: UITableViewController {
    var ingredientList = [RecipeItem]()
    var displayHelp = DisplayHelper()

    //All the info we need is already passed to us by productViewController, so we don't need to do anything on View Load.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ingredientList.count
    }

    //Each of our cells contains the Item's name, the Quantity, and the value.
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("recipeViewCell", forIndexPath: indexPath) as! recipeViewCell

        // Configure the cell...
        let row = indexPath.row
        cell.ingredientNameLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        cell.ingredientNameLabel.text = displayHelp.nameFromID(ingredientList[row].getID())
        
        cell.ingredientQuantityLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        cell.ingredientQuantityLabel.text = "x" + String(ingredientList[row].getQuantity())
        
        cell.ingredientValueLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        //Siege Masters Guides, Philosopher's Stones, and Mystic Crystals are bound on acquire, and don't cost gold. Thus, we have a special case to display their unique costs, rather than simply listing their cost as "0c"
        if(ingredientList[row].getID() == 20798 || ingredientList[row].getID() == 20796 || ingredientList[row].getID() == 20799){
            if(ingredientList[row].getID() == 20798){
                cell.ingredientValueLabel.text = "1 Spirit Shard"
            }else if(ingredientList[row].getID() == 20796){
                cell.ingredientValueLabel.text = "1 Spirit Shard/10"
            }else{
                cell.ingredientValueLabel.text = "3 Spirit Shard/5"
            }
        }else{
            cell.ingredientValueLabel.text = displayHelp.goldValue(ingredientList[row].getValue())
        }

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
