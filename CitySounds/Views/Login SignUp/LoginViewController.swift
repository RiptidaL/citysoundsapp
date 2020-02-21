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
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
     func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"
        {
            textView.resignFirstResponder()
            return false
        }
        return true
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
                
                   self.transitionToHome()
                    
                }
                
                
            }
            
        }
        
    func showError(_ message: String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome() {
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? TableViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }
    
    
    

}
