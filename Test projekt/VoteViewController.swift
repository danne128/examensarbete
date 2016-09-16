//
//  VoteViewController.swift
//  Test projekt
//
//  Created by Daniel Trondsen Wallin on 06/09/16.
//  Copyright © 2016 Daniel Trondsen Wallin. All rights reserved.
//

import UIKit
import Firebase

class VoteViewController: UIViewController {
    
    let rootRef = FIRDatabase.database().reference()

    @IBOutlet weak var decisionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        decisionLabel.text = "Your decision is: ?"
    }
    
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
                
                let number = UInt32(objects.count)
                
                let random = Int(arc4random_uniform(number))
                
                self.decisionLabel.text = "Your decision is: \(objects.map { $0.value! }[random])"
                
            }
        })
    }
    
    
    @IBAction func moveBack(sender: AnyObject) {
        try! FIRAuth.auth()!.signOut()
        self.navigationController?.popToRootViewControllerAnimated(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func makeDecisionButtonClicked(sender: AnyObject) {
        fetchList()
    }
}
