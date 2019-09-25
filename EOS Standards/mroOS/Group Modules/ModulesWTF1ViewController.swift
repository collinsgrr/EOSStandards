//
//  ModulesWTF1ViewController.swift
//  mroOS
//
//  Created by Gareth Collins on 22/09/2019.
//  Copyright © 2019 Gareth Collins. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ModulesWTF1ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    
    var taskName = ["Confirm operator is authorized to carry out the task by checking their Stamp Authorisation Sheet (Sample check one operator)","Is there any uncontrolled documentation within the cell? (Spot check in all cell areas)","Check Shift & Task handover has been stamped off at start and end of shift (Spot check in all cell areas)","When starting work on a new engine / module on strip or build, ensure all material from previous assembly is correctly dispositioned","Parts are not stored or moved with loose metal to metal contact (spot check in all cell areas)","Only purpose built pallets (wooden or plastic) allowed in cell (spot check in all cell areas)","All containers/pallets are suitably sized for component - nothing overhanging box or pallet (spot check in all cell areas)","No parts stored on floor or in gangways (spot check in all cell areas)","No part is in direct contact with wooden pallet","Are FOD Bins and Scrap removal processes being adhered to?","Sample check COSHH items in Cupboards and bays for readable labels and dates","Submit all equipment before 'date due' and record its placed in the cage","Torque rigs and Torque Trolley compliant to SOPD078","Identify any overdue equipment as 'missing', escalate to the 8:30am meeting","Deactivate missing equipment as required","Check sharps process is being carried out in line with SOP D159","Check the Quality T-Card board for QNs and NCRs which are allocated to me.","Confirm that no QNs or NCRs allocated to me will turn RED in the current week, otherwise take action to ensure that the QNs or NCRs do not turn RED","Is the housekeeping of the zones per the cells 5S zone standards? (Spot check in all cell areas)","Are emergency exits clear from obstruction? (Check all exits in the cell area)","Ensure both of the 2 zones are dated and populated with Evacuation Marshall and First Aider for your shift","Is the First Aider maintaining the First Aid Box, Burns Kit (where applicable), Body flud Spill Kit (where applicable)","Are operators wearing mandatory PPE - see blue / white signage for the area? (spot check in all cell areas)","If any lifting equipment is used, sample check the equipment is clearly tagged and within date (spot check in all cell areas - focus on what is being used)","Check area for trailing cables and 'daisy chain' of extension leads","Check one recycling bin, is correct waste in the bin?","Hazard spot for undesirable conditions; fix and record on database","Check to ensure that all emergency exits and external doors are secured shut.","Confirm that all of the live HSE alerts within the Ops Center have been briefed and stamped for, for your area."]
       
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return taskName.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "modulesWTF1Cell", for: indexPath)
           cell.textLabel?.text = taskName[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        
        let switchView = UISwitch(frame: .zero)
        switchView.setOn(false, animated: true)
        switchView.tag = indexPath.row
        switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        cell.accessoryView = switchView
        
           return cell
       }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        if indexPath.section == 0 {
            return 150
        } else {
            return 150
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        if indexPath.section == 0{
            return 150
        } else{
            return 150
        }
    }
    
    @objc func switchChanged(_ sender: UISwitch!){
        print("table row switch changed \(sender.tag)")
        print("The switch is \(sender.isOn ? "ON" : "OFF")")
    }
       
    //   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //     let area = taskName[indexPath.row]
        //   if taskName[indexPath.row] == "Start of Shift Brief"{
          //   performSegue(withIdentifier: "modulesSOSBriefSegue", sender: area)
           //} else {
       // }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
    
    }
    
    @IBOutlet weak var tableView: UITableView!

}
