//
//  AddGroupViewController.swift
//  Test projekt
//
//  Created by Daniel Trondsen Wallin on 13/09/16.
//  Copyright © 2016 Daniel Trondsen Wallin. All rights reserved.
//

import UIKit
import Firebase

class AddGroupViewController: UIViewController {

    @IBOutlet weak var addGroupTextField: UITextField!
    @IBOutlet weak var savedThingsLabel: UILabel!
    
    var moveOn: Bool = false
    
    let rootRef = FIRDatabase.database().reference()
    
    var olikaOrd: [String!] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchList()
        moveOn = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchList() {
        
        func fetchList() {
            
            rootRef.child("list").observeSingleEventOfType(.Value, withBlock: { snapshot in
                //Checking if snapshot works
                //print(snapshot.childrenCount)
                
                if let objects = snapshot.children.allObjects as? [FIRDataSnapshot] {
                    //print(objects)
                    //print(objects.count)
                    //print(objects[1])
                    //self.decisionLabel.text = "\(objects[2])"
                    //print(objects.map { $0.value! })
                    
                    self.savedThingsLabel.text = "You have: \(objects.map { $0.value! }) saved)"
                }
            })
        }
    }
    
    
    @IBAction func addThingsToList(sender: AnyObject) {
        
        guard let thing = addGroupTextField.text where !thing.isEmpty else {
            print("Ohoh, something went wrong")
            return
        }
        
        olikaOrd.append(thing)
        addGroupTextField.text = nil
        //print(olikaOrd)
        savedThingsLabel.text = ("Saved things: \(olikaOrd)")
        
    }

    @IBAction func startVotingWasPressed(sender: AnyObject) {
        
        if (olikaOrd.count == 0) {
            print("Ohoh something went wrong")
        }
        else {
            self.moveOn = true
            self.performSegueWithIdentifier("moveToVote", sender: nil)
            let values = ["list": olikaOrd]
            
            rootRef.updateChildValues(values) { (err, ref) in
                if err != nil {
                    print(err)
                    return
                }
                
            }
        }
    }
    
    @IBAction func addGroupWasTouched(sender: AnyObject) {
        
        let groupRef = self.rootRef.child("lists")
        let values = ["list": olikaOrd]
        
        groupRef.updateChildValues(values) { (err, ref) in
            if err != nil {
                print(err)
                return
            }
            return
        }
    }
    
}









