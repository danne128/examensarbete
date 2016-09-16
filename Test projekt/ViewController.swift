//
//  ViewController.swift
//  Test projekt
//
//  Created by Daniel Trondsen Wallin on 30/08/16.
//  Copyright © 2016 Daniel Trondsen Wallin. All rights reserved.
//

import UIKit
import Firebase
//import FirebaseAuth

class ViewController: UIViewController {
    
    let rootRef = FIRDatabase.database().reference()
    var moveOn: Bool = false

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.navigationBarHidden = true
        //view.backgroundColor = UIColor(red: 80/255, green: 125/255, blue: 213/255, alpha: 1)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
        moveOn = false
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
    @IBAction func signInWasTouched(sender: AnyObject) {
        
        FIRAuth.auth()?.signInWithEmail(emailTextField.text!, password: passwordTextField.text!, completion: {(user, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            else {
                print("User logged in...")
                self.moveOn = true
                self.performSegueWithIdentifier("moveToVote", sender: nil)
                self.emailTextField.text = ""
                self.passwordTextField.text = ""
            }
        })
        
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        //print(moveOn)
        return moveOn
    }

    @IBAction func signUpWasTouched(sender: AnyObject) {
        self.moveOn = true
        self.performSegueWithIdentifier("moveToReg", sender: nil)
    }
}

