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
    @IBOutlet weak var nextButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let image = (info[UIImagePickerController.InfoKey.originalImage] as! UIImage)
        imageView.contentMode = .scaleAspectFill
        imageView.image = image

        
        imagePicker.dismiss(animated: true, completion: nil)
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
        office = NSNumber()
        osd = 0
        engines = 0
        modules = 0
        ldc = 0
        
        
        let card = ["name": prodTitle , "description" : prodDetails ,"supplier":prodSupplier ,"officeBool":officeSwitch ?? false,"enginesBool":enginesSwitch ?? false,"modulesBool":modulesSwitch ?? false,"osdBool":osanddSwitch ?? false,"ldcBool":ldcSwitch ?? false] as NSDictionary
        Database.database().reference().child(categoryNameValue!).child("Cards").childByAutoId().setValue(card)
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
       
        
    }
    
}