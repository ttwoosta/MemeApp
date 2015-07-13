//
//  TMSentMemesTableVC.swift
//  MemeApp
//
//  Created by Tu Tong on 7/12/15.
//  Copyright (c) 2015 Tu Tong. All rights reserved.
//

import UIKit

class TMSentMemesTableVC: UITableViewController {
    
    var sharedMemes: [TMMeme]!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.sharedMemes = AppDelegate.sharedAppDelegate().sharedMemes
        self.tableView.reloadData()
    }
    
    /////////////////////
    // UITableViewDataSource
    /////////////////////
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sharedMemes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        let meme = sharedMemes[indexPath.row]
        
        cell.textLabel?.text = meme.topText
        cell.detailTextLabel?.text = meme.bottomText
        cell.imageView?.image = meme.memeImage
        
        return cell
    }
    
    /////////////////////
    // Segue
    /////////////////////
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detailViewController" {
            // retrieves meme from selected cell
            let cell = sender as! UITableViewCell
            let indexPath: NSIndexPath = self.tableView.indexPathForCell(cell)!
            let meme = sharedMemes[indexPath.row]
            
            // set meme to detail view controller
            let vc = segue.destinationViewController as! TMMemeDetailVC
            vc.meme = meme
        }
    }
    
    
}
