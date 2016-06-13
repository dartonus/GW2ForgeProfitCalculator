//
//  categoryTableController.swift
//  GW2CraftProfit
//
//  Created by Callum Grant on 4/24/16.
//  Copyright © 2016 Callum Grant. All rights reserved.
//

import UIKit

//Our initial landing page, the Category list.
class categoryTableController: UITableViewController {
    var categories = [String]()
    var idlist = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let category = CategoryHandler()
        categories = category.getCategories()
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
        return categories.count
    }

    //Our cells contain the category names.
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("categoryTableCell", forIndexPath: indexPath) as! categoryTableViewCell
        
        let row = indexPath.row
        cell.categoryLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        cell.categoryLabel.text = categories[row]

        // Configure the cell...

        return cell
    }
    
    //When a category is selected, store the IDList for the category in preparation for use in the next View.
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        let selectedCellName = categories[indexPath.row]
        
        let category = CategoryHandler()
        self.idlist = category.getIDs(selectedCellName)
        
        performSegueWithIdentifier("categoryProductSegue", sender: self)
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
        if(segue.identifier == "categoryProductSegue"){
            let nextViewController = (segue.destinationViewController as! productViewController)
            nextViewController.idList = self.idlist
        }
    }


}
