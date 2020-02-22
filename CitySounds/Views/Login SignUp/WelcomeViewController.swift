//
//  WelcomeViewController.swift
//  CitySounds
//
//  Created by Scott on 2/19/20.
//  Copyright © 2020 RiptidaL. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    // Hide the Navigation Bar
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    // Show the Navigation Bar
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        setUpElements()
        
    }
    

    func setUpElements() {
        
       
        
        // Style elements
        Utilities.styleFilledButton(loginButton)
        Utilities.styleHollowButton(signUpButton)
        
    }
    
    
    
    
    
    
    
    

}
