//
//  SavedTableViewController.swift
//  Test projekt
//
//  Created by Daniel Trondsen Wallin on 12/09/16.
//  Copyright © 2016 Daniel Trondsen Wallin. All rights reserved.
//

import UIKit
import Firebase

class SavedTableViewController: UITableViewController {
    
    let rootRef = FIRDatabase.database().reference()
    var groups: [Group] = []
    var selectedItemRow: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        rootRef.child("groups").observeEventType(.Value) { (data: FIRDataSnapshot!) in
            var newGroups: [Group] = []
            
            for group in data.children {
                
                let newGroup: Group = Group(dataSnapshot: group as! FIRDataSnapshot)
                
                newGroups.append(newGroup)
            }
            
            self.groups = newGroups
            self.tableView.reloadData()
            print(self.groups.count)
            
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        selectedItemRow = 0
        selectedItemRow = nil
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedItemRow = indexPath.row
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("groupCell", forIndexPath: indexPath)
        
        if let textLabel = cell.textLabel {
            textLabel.text = "\(groups[indexPath.row].group)"
        }
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    @IBAction func logOutPressed(sender: AnyObject) {
        try! FIRAuth.auth()!.signOut()
        print("fuck you")
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    @IBAction func addGroupPressed(sender: AnyObject) {
    }
    

}
