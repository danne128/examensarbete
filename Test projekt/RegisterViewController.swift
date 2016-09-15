//
//  RegisterViewController.swift
//  Test projekt
//
//  Created by Daniel Trondsen Wallin on 02/09/16.
//  Copyright © 2016 Daniel Trondsen Wallin. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    let rootRef = FIRDatabase.database().reference()
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationController?.navigationBarHidden = false
        // Do any additional setup after loading the view.
        //view.backgroundColor = UIColor(red: 80/255, green: 125/255, blue: 213/255, alpha: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerButton(sender: AnyObject) {
        guard let email = emailTextField.text, password = passwordTextField.text, name = nameTextField.text else {
            print("Form is not valid")
            return
        }
        
        FIRAuth.auth()?.createUserWithEmail(email, password: password, completion: { (user: FIRUser?, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            guard let uid = user?.uid else {
                return
            }
            
            let usersRef = self.rootRef.child("user").child(uid)
            let values = ["name": name, "email": email]
            
            usersRef.updateChildValues(values) { (err, ref) in
                if err != nil {
                    print(err)
                    return
                }
                
                print("Saved user succesfully")
                self.navigationController?.popViewControllerAnimated(true)
                
            }
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
