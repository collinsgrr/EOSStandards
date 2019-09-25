//
//  ModulesViewController.swift
//  mroOS
//
//  Created by Gareth Collins on 21/09/2019.
//  Copyright © 2019 Gareth Collins. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ModulesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var taskName = ["Start of Shift Brief","Walk the Floor 1","SQCDP","Walk the Floor 2","Escalation Meeting","WIP Status"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = taskName[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let area = taskName[indexPath.row]
        if taskName[indexPath.row] == "Start of Shift Brief"{
          performSegue(withIdentifier: "modulesSOSBriefSegue", sender: area)
        } else {
                if taskName[indexPath.row] == "Walk the Floor 1"{
                performSegue(withIdentifier: "modulesWTF1Segue", sender: area)
        } else {
                if taskName[indexPath.row] == "SQCDP"{
                performSegue(withIdentifier: "modulesSQCDPSegue", sender: area)
        } else {
                if taskName[indexPath.row] == "Walk the Floor 2"{
                performSegue(withIdentifier: "modulesWTF2Segue", sender: area)
        } else {
                if taskName[indexPath.row] == "Escalation Meeting"{
                performSegue(withIdentifier: "modulesEscalationSegue", sender: area)
        } else {
                if taskName[indexPath.row] == "WIP Status"{
                performSegue(withIdentifier: "modulesWIPSegue", sender: area)
                            }
                        }
                    }
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var tableView: UITableView!
}
