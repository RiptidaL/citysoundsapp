//
//  UserProfileViewController.swift
//  CitySounds
//
//  Created by Scott on 2/23/20.
//  Copyright © 2020 RiptidaL. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class UserProfileViewController: UIViewController {

    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var email: UILabel!
    
    @IBOutlet weak var signOutButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getUserProfileData()


        
        
    }
    

    @IBAction func signOutButtonTapped(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
            } catch let err {
                print(err)
        }
        
        
        performSegue(withIdentifier: "goToEvents", sender: self)
    

    }
    
    
    
    func getUserProfileData() {

        if Auth.auth().currentUser != nil {
            
            self.email.text = Auth.auth().currentUser?.email
        
            let userData = Firestore.firestore().collection("users").whereField("uid", isEqualTo: Auth.auth().currentUser?.uid ?? "")
            userData.getDocuments { (querySnapshot, err) in
                if let err = err {
                    print(err.localizedDescription)
                    return
                } else if querySnapshot!.documents.count != 1 {
                    print("More than one document or none")
                    
                } else {
                    let document = querySnapshot!.documents.first
                    let dataDescription = document?.data()
                    
                    guard let firstNameDB = dataDescription?["firstname"]
                        
                        
                        else {
                            return
                    }
                    
                    guard let lastNameDB = dataDescription?["lastname"]
                        else {
                            return
                            
                    }
                    
                    self.firstName.text = firstNameDB as? String
                    self.lastName.text = lastNameDB as? String
                    
                    }
                }
          
            
            }
            
            
        }



    
    
    
}
