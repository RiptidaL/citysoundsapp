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
import FirebaseFirestore

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
    
    
    
    // Date Picker
    private var datePicker: UIDatePicker?
    
    // Establish sortDate variable
//    var sortDate: String! = ""
    
    // Firebase reference
    var ref: DatabaseReference!
    let db = Firestore.firestore()
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done",style: .done, target: self, action: #selector(onClickDoneButton))
        toolBar.setItems([space, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        eventDate.inputAccessoryView = toolBar
        doneButton.tintColor = .red

        
        
        
        
        // Date Picker
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        
        eventDate.inputView = datePicker
        
        
        
        // Firestore
        
        
        // Real-Time DB
        ref = Database.database().reference()
        self.eventDate.delegate = self
        self.eventName.delegate = self
        self.eventLocation.delegate = self
        self.eventLocationAddress.delegate = self
        self.eventPrice.delegate = self
        self.eventGenre.delegate = self
        self.eventArtists.delegate = self
        self.eventTime.delegate = self
        
        // Setup style defaults
        setUpElements()
        
    }
    
    
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    

    
    @objc func dateChanged(datePicker: UIDatePicker) {
        
        // Format visible date
        let visibleDateFormatter = DateFormatter()
        visibleDateFormatter.dateFormat = "MM/dd/yyyy"
        eventDate.text = visibleDateFormatter.string(from: datePicker.date)
        //view.endEditing(true)
       
//        // Format stored date
//        let storedDateFormatter = DateFormatter()
//        storedDateFormatter.dateFormat = "yyyyMMdd"
//        sortDate = storedDateFormatter.string(from: datePicker.date)
        
       
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
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        self.view.endEditing(true)
//        return false
//    }
    
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case eventName:
            eventDate.becomeFirstResponder()
        case eventDate:
            eventTime.becomeFirstResponder()
        case eventTime:
            eventLocation.becomeFirstResponder()
        case eventLocation:
            eventLocationAddress.becomeFirstResponder()
        case eventLocationAddress:
            eventPrice.becomeFirstResponder()
        case eventPrice:
            eventGenre.becomeFirstResponder()
        case eventGenre:
            eventArtists.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
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
        
        let error = validateField()
        
        if error != nil {
            showError(error!)
            
        } else {
            
            
            
            let db = Firestore.firestore()
            db.collection("upcoming").addDocument(data: [
                "name": eventName.text!,
                "date": eventDate.text!,
                "time": eventTime.text!,
                "location": eventLocation.text!,
                "address": eventLocationAddress.text!,
                "genre": eventGenre.text!,
                "price": eventPrice.text!,
                "artists": eventArtists.text!,
                
            
            ]) { (error) in
                
                if error != nil {
                    self.showError("Error adding event.")
                }
                
            }
            
            self.performSegue(withIdentifier: "goToEvents", sender: sender)
            
        }
        
        
//        let uniqueID = UUID().uuidString
//        self.ref.child("upcoming").child(uniqueID).setValue(["Name":eventName.text,
//                                                             "Location": eventLocation.text,
//                                                             "Date": eventDate.text,
//                                                             "Time": eventTime.text,
//                                                             "Genre": eventGenre.text,
//                                                             "Address": eventLocationAddress.text,
//                                                             "Price": eventPrice.text,
//                                                             "Sort Date": sortDate,
//                                                             "Artists": eventArtists.text
//        ])
//
//
//        showEventAddedText()
//        eraseTextFields()
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    func showEventAddedText() {
        
//        errorLabel.text = "Event has been added!"
//        errorLabel.alpha = 1
//        errorLabel.textColor = .green
        
        performSegue(withIdentifier: "goToEvents", sender: self)
        
        
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
    
    
    
    func showError(_ message: String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    
    
    @objc func onClickDoneButton() {
        
        self.view.endEditing(true)
        
    }
    
    
    
    
}


