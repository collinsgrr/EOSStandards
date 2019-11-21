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

var name = ""
var photoURL = ""
var description = ""
var supplier = ""
var officeBool : NSNumber = 0
var enginesBool : NSNumber = 0
var modulesBool : NSNumber = 0
var osdBool : NSNumber = 0
var ldcBool : NSNumber = 0
}

class furnitureViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var categoryNameValue: String? = ""
    var cards : [Card] = []
    var ref: DatabaseReference!
    var cardSelectedValue : String? = ""

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
            card.name = value["name"] as? String ?? ""
    
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
        cell.textLabel?.text = card.name
        
    return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let card = cards[indexPath.row]
        cardSelectedValue = card.name
        performSegue(withIdentifier: "cardViewSegue", sender: card.name)
        
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        ref = Database.database().reference().child(categoryNameValue!).child("Cards")
        self.ref.observe(DataEventType.childAdded) { (DataSnapshot) in
                print(DataSnapshot)
                
                let card = Card()
                let value = DataSnapshot.value! as! NSDictionary
                card.name = value["name"] as? String ?? ""
                
        
                self.cards.append(card)
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
