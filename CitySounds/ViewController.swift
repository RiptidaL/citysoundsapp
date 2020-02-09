//
//  ViewController.swift
//  CitySounds
//
//  Created by Scott on 2/8/20.
//  Copyright © 2020 RiptidaL. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController {

    @IBOutlet weak var eventName: UITextField!
    
    @IBOutlet weak var eventLocation: UITextField!
    
    var ref: DatabaseReference!
    

    //self.ref.child("users").child(user.uid).setValue(["username": username])
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
    }

    
    
    @IBAction func submitPressed(_ sender: Any) {
        let uniqueID = UUID().uuidString
        self.ref.child("upcoming").child(uniqueID).setValue(["Name":eventName.text, "Location": eventLocation.text])
        
    }
    
    
    
}

