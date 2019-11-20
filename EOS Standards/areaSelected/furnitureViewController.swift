//
//  furnitureViewController.swift
//  EOS Standards
//
//  Created by Gareth Collins on 25/09/2019.
//  Copyright © 2019 Gareth Collins. All rights reserved.
//

import UIKit

class furnitureViewController: UIViewController{ //UITableViewDelegate, UITableViewDataSource{
    
    var categoryNameValue: String? = ""
    
    
    //func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
    //}
    
    //func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //
    //}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        categoryNameLabel?.text = categoryNameValue
    }
    
    
    @IBAction func plusTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "furnitureDetailSegue", sender: nil)
    }
    

    @IBOutlet weak var categoryNameLabel: UILabel!
    
    
}
