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

class ViewController: UIViewController, UITextFieldDelegate {

    
    
    @IBOutlet weak var eventDate: UITextField!
    @IBOutlet weak var eventName: UITextField!
    @IBOutlet weak var eventLocation: UITextField!
    @IBOutlet weak var eventLocationAddress: UITextField!
    @IBOutlet weak var eventPrice: UITextField!
    @IBOutlet weak var eventGenre: UITextField!
    @IBOutlet weak var eventArtists: UITextField!
    @IBOutlet weak var eventTime: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    
    @IBOutlet weak var submitEvent: UIButton!
    
    
    
    
    
    var ref: DatabaseReference!
    

    //self.ref.child("users").child(user.uid).setValue(["username": username])
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //small nav title
        //navigationItem.largeTitleDisplayMode = .never
        
        ref = Database.database().reference()
        self.eventDate.delegate = self
        self.eventName.delegate = self
        self.eventLocation.delegate = self
        self.eventLocationAddress.delegate = self
        self.eventPrice.delegate = self
        self.eventGenre.delegate = self
        self.eventArtists.delegate = self
        self.eventTime.delegate = self
        
        setUpElements()
        
    }

    func setUpElements() {
        
        // Hide error label
        errorLabel.alpha = 0
        
        // Style elements
        Utilities.styleTextField(eventDate)
        Utilities.styleTextField(eventName)
        Utilities.styleTextField(eventLocation)
        Utilities.styleTextField(eventLocationAddress)
        Utilities.styleTextField(eventPrice)
        Utilities.styleTextField(eventGenre)
        Utilities.styleTextField(eventArtists)
        Utilities.styleTextField(eventTime)
        Utilities.styleFilledButton(submitEvent)
        
        
    }
    

   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    // Check the field and validate that the data is correct.
    func validateField() -> String? {
            
        // Check that all fields are filled in
        if eventName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        eventLocation.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        eventDate.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        eventTime.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        eventGenre.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        eventLocationAddress.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        eventPrice.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        eventArtists.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        
        
        return nil
    }
    
    
    
    
    

    
    
    @IBAction func submitPressed(_ sender: Any) {
        
        let uniqueID = UUID().uuidString
        self.ref.child("upcoming").child(uniqueID).setValue(["Name":eventName.text,
                                                             "Location": eventLocation.text,
                                                             "Date": eventDate.text,
                                                             "Time": eventTime.text,
                                                             "Genre": eventGenre.text,
                                                             "Address": eventLocationAddress.text,
                                                             "Price": eventPrice.text,
                                                             "Artists": eventArtists.text
        ])
        
        
        showEventAddedText()
        eraseTextFields()
        
        DispatchQueue.main.asyncAfter(deadline:.now() + 1.0, execute: {
           self.performSegue(withIdentifier:"goToEvents",sender: self)
        })
        
        
        
    }
    
    func showEventAddedText() {
        
        errorLabel.text = "Event has been added!"
        errorLabel.alpha = 1
    }
    
    func eraseTextFields() {
        eventName.text = ""
        eventLocation.text = ""
        eventDate.text = ""
        eventTime.text = ""
        eventGenre.text = ""
        eventLocationAddress.text = ""
        eventPrice.text = ""
        eventArtists.text = ""
    }
    
    
    
    
    
}

