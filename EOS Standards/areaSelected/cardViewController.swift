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

class cardViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
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
    var delRef : DatabaseReference!
       var prodTitle : NSString = ""
       var prodDetails : NSString = ""
       var prodSupplier : NSString = ""
       var office : NSNumber = 0
       var osd : NSNumber = 0
       var engines : NSNumber = 0
       var modules : NSNumber = 0
       var ldc : NSNumber = 0
    var uuid : NSString = NSUUID().uuidString as NSString

     var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
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

    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var fileButton: UIBarButtonItem!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var editSaveButton: UIButton!
    
    @IBAction func deleteTapped(_ sender: Any) {
        editSaveButton.isEnabled = false
        deleteButton.isEnabled = false
        Database.database().reference().child(categoryNameValue).child("Cards").child(cardNameValue).removeValue()
        Storage.storage().reference().child("images").child("\(uuid).jpg").delete { (error) in
            print ("We deleted the image")
        }
    }
    
    
    @IBAction func editTapped(_ sender: Any) {
    
        if editSaveButton.titleLabel!.text == "Edit" {
    officeBoolSwitch.isEnabled = true
    osdBoolSwitch.isEnabled = true
    enginesBoolSwitch.isEnabled = true
    ldcBoolSwitch.isEnabled = true
    modulesBoolSwitch.isEnabled = true
    productTitle.isEnabled = true
    productDetails.isEnabled = true
    productSupplier.isEnabled = true
        cameraButton.isEnabled = true
        fileButton.isEnabled = true
            editSaveButton.setTitle("Save", for: UIControl.State.normal)
        
        } else {
            editSaveButton.setTitle("Edit", for: UIControl.State.normal)
            editSaveButton.isEnabled = false
        Database.database().reference().child(categoryNameValue).child("Cards").child(cardNameValue).removeValue()
            
            let imagesFolder = Storage.storage().reference().child("images").child("\(uuid).jpg")
                   
            let imageData = viewCardImage.image!.jpegData(compressionQuality: 0.1)!
            
            imagesFolder.putData(imageData, metadata: nil) { (metadata, error) in
                print ("we tried to upload")
                guard metadata != nil else {
                    return
                }
                if error != nil {
                                print("we had an error: \(String(describing: error))")
                } else {
                    imagesFolder.downloadURL { (url, error) in
                        self.imageURL = url!.absoluteString
                        print(self.imageURL)
                        print("1")
                        self.performSegue(withIdentifier: "cardEditedSegue", sender: self.imageURL)
                    }
                }
            }
            print("2")

            prodTitle = productTitle.text! as NSString
            prodDetails = productDetails.text! as NSString
            prodSupplier = productSupplier.text! as NSString
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
         let image = (info[UIImagePickerController.InfoKey.originalImage] as! UIImage)
         viewCardImage.contentMode = .scaleAspectFill
         viewCardImage.image = image

         
         imagePicker.dismiss(animated: true, completion: nil)
         editSaveButton.isEnabled = true
     }
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func fileTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if(segue.identifier == "cardEditedSegue"){
                    let displayVC = segue.destination as? DoneViewController
                displayVC!.categoryNameValue = categoryNameValue
                displayVC!.prodTitle = prodTitle
                displayVC!.prodSupplier = prodSupplier
                displayVC!.prodDetails = prodDetails
                displayVC!.office = office
                displayVC!.osd = osd
                displayVC!.engines = engines
                displayVC!.modules = modules
                displayVC!.ldc = ldc
                displayVC!.imageURL = sender as! String
                displayVC!.uuid = uuid

    }
}
}
