//
//  DetailFurnitureViewController.swift
//  EOS Standards
//
//  Created by Gareth Collins on 25/09/2019.
//  Copyright © 2019 Gareth Collins. All rights reserved.
//

import UIKit

public protocol ImagePickerDelegate: class {
    func didSelect(image: UIImage?)
}

open class ImagePicker: NSObject {
    private let pickerController: UIImagePickerController
    private weak var presentationController: UIViewController?
    private weak var delegate: ImagePickerDelegate?
    
    public init(presentationController: UIViewController, delegate: ImagePickerDelegate){
        self.pickerController = UIImagePickerController()
        
        super.init()
        
        self.presentationController = presentationController
        self.delegate = delegate
        
        self.pickerController.delegate = (self as UIImagePickerControllerDelegate & UINavigationControllerDelegate)
        self.pickerController.allowsEditing = false
        self.pickerController.mediaTypes = ["public.image"]
    }
    
    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction?{
    guard UIImagePickerController.isSourceTypeAvailable(type) else {
    return nil
    }
    return UIAlertAction(title: title, style: .default) { [unowned self] _ in
    self.pickerController.sourceType = type
    self.presentationController?.present(self.pickerController, animated: true)
    }
}

public func present(from sourceView: UIView) {
    let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    if let action = self.action(for: .camera, title: "Take Photo") {
        alertController.addAction(action)
    }
    
    alertController.addAction(UIAlertAction(title: "Cancel",style: .cancel, handler: nil))
    
    if UIDevice.current.userInterfaceIdiom == .pad{
        alertController.popoverPresentationController?.sourceView = sourceView
        alertController.popoverPresentationController?.sourceRect = sourceView.bounds
        alertController.popoverPresentationController?.permittedArrowDirections = [.down, .up]
    }
    self.presentationController?.present(alertController, animated: true)
}

    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        controller.dismiss(animated: true, completion: nil)
        
        self.delegate?.didSelect(image: image)
        
    }
}

extension ImagePicker: UIImagePickerControllerDelegate{
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {self.pickerController(picker, didSelect: nil)
    }

    public func imagePickerController(_picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage) else{
            return self.pickerController(_picker, didSelect: nil)
        }
        self.pickerController(_picker, didSelect: image)
    }
}

extension ImagePicker: UINavigationControllerDelegate{

}


class DetailFurnitureViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var imagePicker: ImagePicker!
    
    @IBOutlet weak var productTitle: UITextField!
    
    @IBOutlet weak var productDetails: UITextField!
    
    @IBOutlet weak var productSupplier: UITextField!
    
    @IBOutlet weak var officeSwitch: UISwitch!
    
    @IBOutlet weak var osanddSwitch: UISwitch!
    
    @IBOutlet weak var enginesSwitch: UISwitch!
    
    @IBOutlet weak var ldcSwitch: UISwitch!
    
    @IBOutlet weak var modulesSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    
    @IBAction func cameraTapped(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    @IBAction func nextTapped(_ sender: Any) {
    }
    
}

extension DetailFurnitureViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        self.imageView.image = image
    }
}
