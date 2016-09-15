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
    
    let rootRef = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func addGroupWasTouched(sender: AnyObject) {
        
        guard let groupName = addGroupTextField.text else {
            print("Form is not valid")
            return
        }
        
        
        let groupRef = self.rootRef.child("groups")
        let values = ["groupname": groupName]
        
        groupRef.updateChildValues(values) { (err, ref) in
            if err != nil {
                print(err)
                return
            }
            
        }
        
    }
}
