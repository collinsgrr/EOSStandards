//
//  cardViewController.swift
//  EOS Standards
//
//  Created by Gareth Collins on 21/11/2019.
//  Copyright © 2019 Gareth Collins. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class cardViewController: UIViewController {
    
    var cardNameValue : String = ""
    var categoryNameValue : String = ""
    var ref : DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
         ref = Database.database().reference().child(categoryNameValue).child("Cards").child(cardNameValue)

        // Do any additional setup after loading the view.
    }


}
