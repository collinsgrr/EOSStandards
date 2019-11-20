//
//  ViewController.swift
//  EOS Standards
//
//  Created by Gareth Collins on 25/09/2019.
//  Copyright © 2019 Gareth Collins. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var category = ["Furniture","Machines, Plant and Equipment","Paint","Safety Equipment"]
    var senderSelected: String = ""
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return category.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let categoryCell = UITableViewCell()
        categoryCell.textLabel?.text = category[indexPath.row]
        return categoryCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let area = category[indexPath.row]
    if category[indexPath.row] == "Furniture"{
        performSegue(withIdentifier: "furnitureSegue", sender: area)
    } else {
        if category[indexPath.row] == "Machines, Plant and Equipment"{
            performSegue(withIdentifier: "mpandlSegue", sender: area)
        } else{
            if category[indexPath.row] == "Paint"{
                performSegue(withIdentifier: "paintSegue", sender: area)
            } else{
            performSegue(withIdentifier: "safetySegue", sender: area)
            }
            }
        }
        senderSelected = area
        print(area)
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
   
        tableView.dataSource = self
        tableView.delegate = self
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "furnitureSegue"){
                let displayVC = segue.destination as? furnitureViewController
            displayVC!.categoryNameValue = "Furniture"
        }else{
            if(segue.identifier == "mpandlSegue"){
                    let displayVC = segue.destination as? furnitureViewController
                displayVC!.categoryNameValue = "Machines, Plant and Equip"
            }else{
                if(segue.identifier == "paintSegue"){
                        let displayVC = segue.destination as? furnitureViewController
                    displayVC!.categoryNameValue = "Paint"
                }else{
                    if(segue.identifier == "safetySegue"){
                            let displayVC = segue.destination as? furnitureViewController
                        displayVC!.categoryNameValue = "Safety Equipment"
                        }
                    }
            }
        }
    }
}
