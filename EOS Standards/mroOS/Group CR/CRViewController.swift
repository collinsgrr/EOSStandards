//
//  CRViewController.swift
//  mroOS
//
//  Created by Gareth Collins on 21/09/2019.
//  Copyright © 2019 Gareth Collins. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class CRViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var taskName = ["Start of Shift Brief","Walk the Floor 1","Walk the Floor 2","SQCDP","Escalation Meeting","WIP Status"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = taskName[indexPath.row]
        return cell
    }
    
  //  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     //   let area = taskName[indexPath.row]
      //  if taskName[indexPath.row] == "Engines"{
       //     performSegue(withIdentifier: "enginesSegue", sender: area)
       // } else {
        //    if taskName[indexPath.row] == "Modules"{
         //       performSegue(withIdentifier: "modulesSegue", sender: area)
           // } else{
            //    performSegue(withIdentifier: "crSegue", sender: area)
            //}
        //}
    //}
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var tableView: UITableView!
}
