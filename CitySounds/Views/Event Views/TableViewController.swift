//
//  TableViewController.swift
//  CitySounds
//
//  Created by Scott on 2/8/20.
//  Copyright © 2020 RiptidaL. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase


class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var eventList: UITableView!
    @IBOutlet weak var searchEvents: UISearchBar!
  
    

    
    //Placeholder for an Array of "Event" objects
    var eventArray = [Event]()
    
    // Reference database
    var ref = Database.database().reference()
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
          
        // Get current date as a string to filter out old events
        
        

        
        
        // Hide nav back button
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        
        // Init eventList
        eventList.delegate = self
        eventList.dataSource = self
        
       // Retrieve data from Firebase
        retrieveDatafromFirebase()

        // When view opens call func
        viewDidAppear(true)
        
        
    }
    
    

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventArray.count
    }
    
    
    
   
    

    
    
    // Select cell -> transition to event details
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToEventDetails", sender: self)
        
        
    }
    
    
    
    
    
    
    // Prepare transition
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToEventDetails" {
            let destinationVC = segue.destination as! EventDetailViewController
            let indexPath = self.eventList.indexPathForSelectedRow
            destinationVC.eventDetails = self.eventArray[indexPath!.row]
        }
        
    }
    
    
    
    // Connect Firestore data to cells labels
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        eventList.rowHeight = 100
        
        let cell = eventList.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.eventName.text = eventArray[indexPath.row].name
        cell.eventLocation.text = eventArray[indexPath.row].location
        cell.eventDate.text = eventArray[indexPath.row].date
        cell.eventGenre.text = eventArray[indexPath.row].genre
        
        return cell
        
    }
    
    
    
    
    func retrieveDatafromFirebase() {
        
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        let currentDateString = formatter.string(from: now)
        
        // Retrieve from Firestore
        let db = Firestore.firestore()
        db.collection("upcoming").whereField("date", isGreaterThanOrEqualTo: currentDateString).order(by: "date", descending: false).getDocuments() { (querySnapshot, err) in
            
            if let err = err {
                print("Error getting documents: \(err)")
            
            } else {
                
                for document in querySnapshot!.documents {
                
                    let reference = Event()
                    
                    reference.name = document.data()["name"] as! String
                    reference.location = document.data()["location"] as! String
                    reference.date = document.data()["date"] as! String
                    reference.genre = document.data()["genre"] as! String
                    reference.price = document.data()["price"] as! String
                    reference.time = document.data()["time"] as! String
                    reference.artists = document.data()["artists"] as! String
                    reference.address = document.data()["address"] as! String
//                    reference.sortDate = document.data()["sortdate"] as! String
                    
                    self.eventArray.append(reference)
                    self.eventList.reloadData()
                    
                }
            }
        }
        
        
        
        
        // Firebase real-time DB old code
//        //Function from the Firebase Docs - "snapshot" is a variable that contains the returned value of what is in the database under the "upcoming" node
//        ref.child("upcoming").queryOrdered(byChild: "Sort Date").observe(.childAdded) { (snapshot) in
//
//            //Converting the returned value to a dictionary so that we can access specific values
//            let data = snapshot.value as? NSDictionary
//
//            //Creating an object of the "Event" class
//            let reference = Event()
//
//            //Access Name and Location of the returned dictionary value
//            reference.name = data!["Name"] as! String
//            reference.location = data!["Location"] as! String
//            reference.date = data!["Date"] as! String
//            reference.genre = data!["Genre"] as! String
//            reference.price = data!["Price"] as! String
//            reference.time = data!["Time"] as! String
//            reference.artists = data!["Artists"] as! String
//            reference.address = data!["Address"] as! String
//            reference.sortDate = data!["Sort Date"] as! String
//
//            self.eventArray.append(reference)
//            self.eventList.reloadData()
//
//        }
        
        
        
        
    }
    
    
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        eventList.reloadData()
    }
    
  
    
    
    
    
    
    
    
    


}


