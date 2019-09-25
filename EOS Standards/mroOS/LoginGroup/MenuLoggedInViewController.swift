//
//  MenuLoggedInViewController.swift
//  mroOS
//
//  Created by Gareth Collins on 16/09/2019.
//  Copyright © 2019 Gareth Collins. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

struct CustomData{
var title: String
var image: UIImage
}

class MenuLoggedInViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let data = [
    
        CustomData(title: "BlueChips", image: #imageLiteral(resourceName: "7")),
        CustomData(title: "Gravity", image: #imageLiteral(resourceName: "12")),
        CustomData(title: "Appreciate", image: #imageLiteral(resourceName: "4")),
        CustomData(title: "Squares", image: #imageLiteral(resourceName: "8")),
        CustomData(title: "CountFs", image: #imageLiteral(resourceName: "3")),
        CustomData(title: "Coaching", image: #imageLiteral(resourceName: "9")),
        CustomData(title: "AtYourBest", image: #imageLiteral(resourceName: "5")),
        CustomData(title: "Styles", image: #imageLiteral(resourceName: "19")),
        CustomData(title: "Listening", image: #imageLiteral(resourceName: "14")),
        CustomData(title: "Shadow", image: #imageLiteral(resourceName: "17")),
        CustomData(title: "Brain", image: #imageLiteral(resourceName: "13")),
        CustomData(title: "Curious", image: #imageLiteral(resourceName: "18")),
        CustomData(title: "WhatCanIDo", image: #imageLiteral(resourceName: "1")),
        CustomData(title: "Filters", image: #imageLiteral(resourceName: "11")),
        CustomData(title: "BeHereNow", image: #imageLiteral(resourceName: "6")),
        CustomData(title: "Accountability", image: #imageLiteral(resourceName: "2")),
        CustomData(title: "Results", image: #imageLiteral(resourceName: "16")),
        CustomData(title: "Mood", image: #imageLiteral(resourceName: "15")),
        CustomData(title: "Energy", image: #imageLiteral(resourceName: "10")),
    ]
    
    var teamName = ["Engines","Modules","OS&D"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = teamName[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let area = teamName[indexPath.row]
        if teamName[indexPath.row] == "Engines"{
            performSegue(withIdentifier: "enginesSegue", sender: area)
        } else {
            if teamName[indexPath.row] == "Modules"{
                performSegue(withIdentifier: "modulesSegue", sender: area)
            } else{
                performSegue(withIdentifier: "crSegue", sender: area)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: (Any)? ){
        print("From ", sender as Any)
    }
    
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(customCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 340).isActive = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func logoutTapped(_ sender: Any?) {
        dismiss(animated: true, completion: nil)
        let firebaseAuth = Auth.auth()
        do{
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
    }
    
    
}
extension MenuLoggedInViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewFlowLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height/1.46, height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 19
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! customCell
        cell.backgroundColor = .red
        cell.data = self.data[indexPath.row]
        return cell
    }
    
    
}
class customCell: UICollectionViewCell {
   
    var data: CustomData? {
        didSet {
        guard let data = data else {return}
        bg.image = data.image
        }
    }
    
    fileprivate let bg: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "10")
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(bg)
        bg.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        bg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        bg.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        bg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
