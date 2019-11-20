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
var officeBool = false
var enginesBool = false
var modulesBool = false
var osdBool = false
var ldcBool = false
}

class furnitureViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var categoryNameValue: String? = ""
    var cards : [Card] = []
    var ref: DatabaseReference!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryNameLabel.text = categoryNameValue
        // Do any additional setup after loading the view.
        ref = Database.database().reference().child(categoryNameValue!)
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
    
    @IBAction func plusTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "furnitureDetailSegue", sender: nil)
    }
    

    @IBOutlet weak var categoryNameLabel: UILabel!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
