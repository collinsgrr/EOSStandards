//
//  furnitureViewController.swift
//  EOS Standards
//
//  Created by Gareth Collins on 25/09/2019.
//  Copyright © 2019 Gareth Collins. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

class Card {

    var prodTitle : NSString = ""
    var photoURL : NSString = ""
    var prodDetails : NSString = ""
    var prodSupplier: NSString = ""
    var officeBool : NSNumber = 0
    var enginesBool : NSNumber = 0
    var modulesBool : NSNumber = 0
    var osdBool : NSNumber = 0
    var ldcBool : NSNumber = 0
    var imageURL : NSString = ""
    var uuid : NSString = ""
}

class furnitureViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var categoryNameValue: String? = ""
    var cards : [Card] = []
    var ref: DatabaseReference!
    var cardSelectedValue : String? = ""
    var cardDescription : String? = ""
    var cardSupplier : String? = ""
    var cardOfficeBool : NSNumber = 0
    var cardEnginesBool : NSNumber = 0
    var cardModulesBool : NSNumber = 0
    var cardOSDBool : NSNumber = 0
    var cardLDCBool : NSNumber = 0
    var cardImageURL : String = ""
    var cardUUID : NSString = ""

    @IBOutlet weak var tableView: UITableView!
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
                     #selector(furnitureViewController.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.red
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryNameLabel.text = categoryNameValue
        // Do any additional setup after loading the view.
        ref = Database.database().reference().child(categoryNameValue!).child("Cards")
        tableView.dataSource = self
        tableView.delegate = self
        
        self.ref.observe(DataEventType.childAdded) { (DataSnapshot) in
            print(DataSnapshot)
            
            let card = Card()
            let value = DataSnapshot.value! as! NSDictionary
            card.prodTitle = value["name"] as! NSString
            card.prodDetails = value["description"] as! NSString
            card.prodSupplier = value["supplier"] as! NSString
            card.osdBool = value["osdBool"] as! NSNumber
            card.officeBool = value["officeBool"] as! NSNumber
            card.ldcBool = value["ldcBool"] as! NSNumber
            card.enginesBool = value["enginesBool"] as! NSNumber
            card.modulesBool = value["modulesBool"] as! NSNumber
            card.imageURL = value["imageURL"] as! NSString
            card.uuid = value["uuid"] as! NSString
            
    
            self.cards.append(card)
            self.tableView.reloadData()
        
            
        }
        self.tableView.addSubview(self.refreshControl)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let card = cards[indexPath.row]
        cell.textLabel?.text = card.prodTitle as String
        
    return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let card = cards[indexPath.row]
        cardSelectedValue = card.prodTitle as String
        cardDescription = card.prodDetails as String
        cardSupplier = card.prodSupplier as String
        cardOfficeBool = card.officeBool
        cardEnginesBool = card.enginesBool
        cardModulesBool = card.modulesBool
        cardOSDBool = card.osdBool
        cardLDCBool = card.ldcBool
        cardImageURL = card.imageURL as String
        cardUUID = card.uuid
        
        performSegue(withIdentifier: "cardViewSegue", sender: card.prodTitle)
        
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        ref = Database.database().reference().child(categoryNameValue!).child("Cards")
        self.ref.observe(DataEventType.childAdded) { (DataSnapshot) in
                print(DataSnapshot)
                
                let card = Card()
                let value = DataSnapshot.value! as! NSDictionary
            card.prodTitle = value["name"] as! NSString 
                
                self.tableView.reloadData()
        
        self.tableView.reloadData()
            print("We refreshed")
        refreshControl.endRefreshing()
            print("We stopped refreshing")
            }
    }
    
    @IBAction func plusTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "furnitureDetailSegue", sender: nil)
    }
    

    @IBOutlet weak var categoryNameLabel: UILabel!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if(segue.identifier == "cardViewSegue"){
               let displayVC = segue.destination as? cardViewController
        displayVC!.categoryNameValue = categoryNameValue!
        displayVC!.cardNameValue = cardSelectedValue!
        displayVC!.cardDescriptionValue = cardDescription!
        displayVC!.cardSupplierValue = cardSupplier!
        displayVC!.cardOfficeBoolValue = cardOfficeBool
        displayVC!.cardEnginesBoolValue = cardEnginesBool
        displayVC!.cardModulesBoolValue = cardModulesBool
        displayVC!.cardOSDBoolValue = cardOSDBool
        displayVC!.cardLDCBoolValue = cardLDCBool
        displayVC!.cardImageURL = cardImageURL
        displayVC!.uuid = cardUUID
        print(categoryNameValue!)
        print(cardSelectedValue!)
        print(cardDescription!)
        print(cardSupplier!)
        print(cardOfficeBool)
        print(cardEnginesBool)
        print(cardModulesBool)
        print(cardOSDBool)
        print(cardLDCBool)
        print(cardImageURL)
       }else{
        if(categoryNameValue == "Furniture"){
                let displayVC = segue.destination as? DetailFurnitureViewController
            displayVC!.categoryNameValue = "Furniture"
        }else{
            if(categoryNameValue == "Machines, Plant and Equip"){
                    let displayVC = segue.destination as? DetailFurnitureViewController
                displayVC!.categoryNameValue = "Machines, Plant and Equip"
            }else{
                if(categoryNameValue == "Paint"){
                        let displayVC = segue.destination as? DetailFurnitureViewController
                    displayVC!.categoryNameValue = "Paint"
                }else{
                    if(categoryNameValue == "Safety Equipment"){
                            let displayVC = segue.destination as? DetailFurnitureViewController
                        displayVC!.categoryNameValue = "Safety Equipment"
                        }
                    }
            }
        }
    }
}
}
