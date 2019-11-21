//
//  DoneViewController.swift
//  EOS Standards
//
//  Created by Gareth Collins on 21/11/2019.
//  Copyright © 2019 Gareth Collins. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class DoneViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
    }
    
    @IBAction func doneTapped(_ sender: Any) {
         self.performSegue(withIdentifier: "returnHomeSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}
