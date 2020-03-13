//
//  LogInViewController.swift
//  EOS Standards
//
//  Created by Gareth Collins on 25/09/2019.
//  Copyright © 2019 Gareth Collins. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import QuartzCore

class LogInViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }

    @IBAction func actionTapped(_ sender: Any) {
      
    }
    
    @IBAction func enterTapped(_ sender: Any) {

        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion:
            { (user, error) in
                print("We tried to sign in")
                if error != nil {
                    print("An error occured")
                } else {
                    print("Signed in successfully")
                    self.performSegue(withIdentifier: "signin", sender: nil)
                }
        })
    }
}
