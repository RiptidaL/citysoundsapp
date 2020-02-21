//
//  LoginViewController.swift
//  CitySounds
//
//  Created by Scott on 2/19/20.
//  Copyright © 2020 RiptidaL. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var emailLoginTextField: UITextField!
    @IBOutlet weak var passwordLoginTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var donothaveaccountButton: UIButton!
    
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    // Hide the Navigation Bar
            self.navigationController?.setNavigationBarHidden(true, animated: false)
        }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    // Show the Navigation Bar
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        
        // small nav title
        navigationItem.largeTitleDisplayMode = .never
        
        
        setUpElements()
    }
    
    func setUpElements() {
        
        // Hide error label
        errorLabel.alpha = 0
        
        // Style elements
        Utilities.styleTextField(emailLoginTextField)
        Utilities.styleTextField(passwordLoginTextField)
        Utilities.styleFilledButton(loginButton)
        Utilities.styleHollowButton(donothaveaccountButton)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
     
    
    
    
    @IBAction func loginTapped(_ sender: Any) {
    
        // Validate text fields
        
        //Create cleaned versions of the text field
        let email = emailLoginTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordLoginTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                // Could not sign in
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            } else {
                
                self.performSegue(withIdentifier: "goToEvents", sender: sender)
                
                
                    
                }
                
                
            }
            
        }
        
    func showError(_ message: String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    
   
    
    

}
