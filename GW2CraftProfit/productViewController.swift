//
//  productViewController.swift
//  GW2CraftProfit
//
//  Created by Callum Grant on 4/24/16.
//  Copyright © 2016 Callum Grant. All rights reserved.
//

import UIKit

class productViewController: UITableViewController {
    var idList = [Int]()
    var productList = [RecipeProduct]()
    let displayHelp = DisplayHelper()
    var recipe = [RecipeItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        //Because the categoryTableController just passes an array of IDs, we generate the RecipeProduct item for each received ID.
        //This also means that refreshing the list and values can be done by backing out to the category menu and selecting the category again.
        for id in self.idList{
            productList.append(RecipeProduct(id: id))
        }
        
        //Sort by profitability.
        productList.sortInPlace(){
            $0.getProfit() > $1.getProfit()
        }
        
        tableView.estimatedRowHeight = 10

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
        return idList.count
    }

    //Our tables display the name of each product, and the net gain/loss of crafting it with instant buys/sells.
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("productViewCell", forIndexPath: indexPath) as! productViewCell
        
        let row = indexPath.row
        cell.productItemLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        cell.productItemLabel.text = displayHelp.nameFromID(productList[row].getID())
        
        let itemProfit = productList[row].getProfit()
        cell.productProfitLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        //If we're losing money on a craft, color the value Red so that we can quickly tell.
        if(itemProfit < 0){
            cell.productProfitLabel.textColor = UIColor.redColor()
        }else{
            cell.productProfitLabel.textColor = UIColor.blackColor()
        }
        cell.productProfitLabel.textAlignment = NSTextAlignment.Right
        cell.productProfitLabel.text = displayHelp.goldValue(itemProfit)
        // Configure the cell...

        return cell
    }
    
    //When a Product is selected, store its recipe in preparation for the segue to the next view.
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        let selectedProduct = productList[indexPath.row]
        
        self.recipe = selectedProduct.getRecipe()
        
        performSegueWithIdentifier("productRecipeSegue", sender: self)
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "productRecipeSegue"){
            let nextViewController = (segue.destinationViewController as! recipeViewController)
            nextViewController.ingredientList = self.recipe
        }

    }
    

}
