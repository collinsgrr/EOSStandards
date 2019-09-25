//
//  RegisterViewController.swift
//  mroOS
//
//  Created by Gareth Collins on 15/09/2019.
//  Copyright © 2019 Gareth Collins. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


class RegisterViewController: UIViewController {

    
    
    @IBOutlet weak var registerEmailTextField: UITextField!
    var fullEmail : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func registerTapped(_ sender: Any) {
        fullEmail = registerEmailTextField.text!
        print(fullEmail)
        Auth.auth().createUser(withEmail: self.fullEmail, password: "eospl123") { authResult, error in
            print("We tried to register")
            if error != nil {
                print("An error occured")
            } else {
                print("Registered successfully")
                Auth.auth().signIn(withEmail: self.fullEmail, password: "eospl123", completion:
                    { (user, error) in
                        print("We tried to sign in")
                        if error != nil {
                            print("An error occured")
                       } else {
                            print("Signed in successfully")
                            self.dismiss(animated: true, completion: nil)
                        }
                })
            }
        }
    }
}
