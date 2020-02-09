//
//  TableViewController.swift
//  CitySounds
//
//  Created by Scott on 2/8/20.
//  Copyright © 2020 RiptidaL. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var eventList: UITableView!
    
    
    var eventArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventList.delegate = self
        eventList.dataSource = self
        
        FirebaseApp.configure()
        let ref = Database.database().reference()
        
       
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        eventList.rowHeight = 100
        let cell = eventList.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
    
        return cell
    }
    
    



}

