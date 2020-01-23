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

       var categoryNameValue: String? = ""
       var prodTitle : NSString = ""
       var prodDetails : NSString = ""
       var prodSupplier : NSString = ""
       var office : NSNumber = 0
       var osd : NSNumber = 0
       var engines : NSNumber = 0
       var modules : NSNumber = 0
       var ldc : NSNumber = 0
       var imageURL : String = ""
        var uuid : NSString = ""
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
        let card = ["name": prodTitle , "description" : prodDetails ,"supplier":prodSupplier ,"officeBool":office ,"enginesBool":engines ,"modulesBool":modules ,"osdBool":osd,"ldcBool":ldc,"imageURL":imageURL,"uuid":uuid] as NSDictionary
        Database.database().reference().child(categoryNameValue!).child("Cards").child(prodTitle as String).setValue(card)
        print(card)
    }
    
    @IBAction func doneTapped(_ sender: Any) {
         self.performSegue(withIdentifier: "returnHomeSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}
