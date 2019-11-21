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
import SDWebImage

class cardViewController: UIViewController {
    
    var cardNameValue : String = ""
    var categoryNameValue : String = ""
    var cardDescriptionValue : String? = ""
    var cardSupplierValue : String? = ""
    var cardOfficeBoolValue : NSNumber = 0
    var cardEnginesBoolValue : NSNumber = 0
    var cardModulesBoolValue : NSNumber = 0
    var cardOSDBoolValue : NSNumber = 0
    var cardLDCBoolValue : NSNumber = 0
    var cardImageURL: String = ""
    var imageURL: String = ""
    var ref : DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         ref = Database.database().reference().child(categoryNameValue).child("Cards").child(cardNameValue)

        productTitle.text = cardNameValue
        productDetails.text = cardDescriptionValue
        productSupplier.text = cardSupplierValue
        
        
        officeBoolSwitch.isOn = cardOfficeBoolValue as! Bool
        osdBoolSwitch.isOn = cardOSDBoolValue as! Bool
        enginesBoolSwitch.isOn = cardEnginesBoolValue as! Bool
        ldcBoolSwitch.isOn = cardLDCBoolValue as! Bool
        modulesBoolSwitch.isOn = cardModulesBoolValue as! Bool
        
        officeBoolSwitch.isEnabled = false
        osdBoolSwitch.isEnabled = false
        enginesBoolSwitch.isEnabled = false
        ldcBoolSwitch.isEnabled = false
        modulesBoolSwitch.isEnabled = false
        productTitle.isEnabled = false
        productDetails.isEnabled = false
        productSupplier.isEnabled = false
        
        imageURL = cardImageURL as String
        print(imageURL)
        viewCardImage.sd_setImage(with: URL(string: imageURL))
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var productTitle: UITextField!
    @IBOutlet weak var productDetails: UITextField!
    @IBOutlet weak var productSupplier: UITextField!
    
    @IBOutlet weak var officeBoolSwitch: UISwitch!
    @IBOutlet weak var osdBoolSwitch: UISwitch!
    @IBOutlet weak var enginesBoolSwitch: UISwitch!
    @IBOutlet weak var ldcBoolSwitch: UISwitch!
    @IBOutlet weak var modulesBoolSwitch: UISwitch!
    
    @IBOutlet weak var viewCardImage: UIImageView!

    
    
    
    
    
    
}
