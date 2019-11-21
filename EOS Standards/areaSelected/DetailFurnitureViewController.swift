//
//  DetailFurnitureViewController.swift
//  EOS Standards
//
//  Created by Gareth Collins on 25/09/2019.
//  Copyright © 2019 Gareth Collins. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class DetailFurnitureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var categoryNameValue: String? = ""
    var prodTitle : NSString = ""
    var prodDetails : NSString = ""
    var prodSupplier : NSString = ""
    var office : NSNumber = 0
    var osd : NSNumber = 0
    var engines : NSNumber = 0
    var modules : NSNumber = 0
    var ldc : NSNumber = 0
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var productTitle: UITextField!
    @IBOutlet weak var productDetails: UITextField!
    @IBOutlet weak var productSupplier: UITextField!
     
    @IBOutlet weak var officeSwitch: UISwitch!
    @IBOutlet weak var osanddSwitch: UISwitch!
    @IBOutlet weak var enginesSwitch: UISwitch!
    @IBOutlet weak var ldcSwitch: UISwitch!
    @IBOutlet weak var modulesSwitch: UISwitch!
    
    
    @IBAction func officeTapped(_ sender: Any) {
        if officeSwitch.isOn {
            officeSwitch.setOn(true, animated:true)
            print(office)
        } else {
            officeSwitch.setOn(false, animated:true)
            office = 0
        }
    }
    @IBAction func engineTapped(_ sender: Any) {
        if enginesSwitch.isOn {
                  enginesSwitch.setOn(true, animated:true)
            engines = 1
              } else {
                  enginesSwitch.setOn(false, animated:true)
            engines = 0
              }
    }
    
    @IBAction func modulesTapped(_ sender: Any) {
       if modulesSwitch.isOn {
            modulesSwitch.setOn(true, animated:true)
        modules = 1
        } else {
            modulesSwitch.setOn(false, animated:true)
        modules = 0
        }
    }
    
    @IBAction func osdTapped(_ sender: Any) {
        if osanddSwitch.isOn {
                osanddSwitch.setOn(true, animated:true)
            osd = 1
                     } else {
                osanddSwitch.setOn(false, animated:true)
            osd = 0
                     }
    }
    
    @IBAction func ldcTapped(_ sender: Any) {
        if ldcSwitch.isOn {
            ldcSwitch.setOn(true, animated:true)
            ldc = 1
        } else {
           ldcSwitch.setOn(false, animated:true)
            ldc = 0
        }
    }
    
    @IBOutlet weak var nextButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        nextButton.isEnabled = false
        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let image = (info[UIImagePickerController.InfoKey.originalImage] as! UIImage)
        imageView.contentMode = .scaleAspectFill
        imageView.image = image

        
        imagePicker.dismiss(animated: true, completion: nil)
        nextButton.isEnabled = true
    }
    
    @IBAction func fileTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
              imagePicker.allowsEditing = false
              present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func cameraTapped(_ sender: UIButton) {
        
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        
        nextButton.isEnabled = false
        
        let imagesFolder = Storage.storage().reference().child("images")
               
        let imageData = imageView.image!.jpegData(compressionQuality: 0.1)!
               
        imagesFolder.child("\(NSUUID().uuidString).jpg").putData(imageData, metadata: nil) { (metadata, error) in
        print ("we tried to upload")
            if error != nil {
                            print("we had an error: \(String(describing: error))")
            } else {
                    self.performSegue(withIdentifier: "furnitureDoneSegue", sender: nil)
                   }
               }

        prodTitle = productTitle.text! as NSString
        prodDetails = productDetails.text! as NSString
        prodSupplier = productSupplier.text! as NSString
        
        let card = ["name": prodTitle , "description" : prodDetails ,"supplier":prodSupplier ,"officeBool":office ,"enginesBool":engines ,"modulesBool":modules ,"osdBool":osd,"ldcBool":ldc] as NSDictionary
        Database.database().reference().child(categoryNameValue!).child("Cards").child(productTitle.text!).setValue(card)
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}
