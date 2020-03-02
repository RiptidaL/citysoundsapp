//
//  WelcomeViewController.swift
//  CitySounds
//
//  Created by Scott on 2/19/20.
//  Copyright © 2020 RiptidaL. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class WelcomeViewController: UIViewController {

    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var backgroundVideo: UIView!
    @IBOutlet weak var loginButton: UIButton!
    
    
    // Hide status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }

    
    
    
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

        setupView()
        
        // Do any additional setup after loading the view.
        setUpElements()
        
    }
    

    func setUpElements() {
        
       
        
        // Style elements
        Utilities.styleFilledButton(loginButton)
        Utilities.styleFilledWhiteButton(signUpButton)
        
    }
    
    
    
    private func setupView() {
        let path = URL(fileURLWithPath: Bundle.main.path(forResource: "welcome2", ofType: "mov")!)
        let player = AVPlayer(url: path)

        
        let newLayer = AVPlayerLayer(player: player)
        newLayer.frame = self.backgroundVideo.bounds
//        let newLayer = AVPlayerLayer(player: player)
//        newLayer.frame = self.backgroundVideo.frame
        self.backgroundVideo.layer.addSublayer(newLayer)
        newLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill

        player.play()
        player.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none

        NotificationCenter.default.addObserver(self, selector: #selector(WelcomeViewController.videoDidPlayToEnd(_:)), name: NSNotification.Name(rawValue: "AVPlayerItemDidPlayToEndTimeNotification"), object: player.currentItem)

    }
    
    
    
    
    
    
    
    @objc func videoDidPlayToEnd(_ notification: Notification) {
        let player: AVPlayerItem = notification.object as! AVPlayerItem
        player.seek(to: CMTime.zero, completionHandler: nil)
    }
    
    
    @IBAction func goToLoginButton(_ sender: Any) {
        NotificationCenter.default.removeObserver(self)
        self.performSegue(withIdentifier: "goToLogin", sender: sender)
        
    }
    
    @IBAction func goToSignUp(_ sender: Any) {
        NotificationCenter.default.removeObserver(self)
        self.performSegue(withIdentifier: "goToSignUp", sender: sender)
        
    }
    
    
    @IBAction func goToEvents(_ sender: Any) {
        NotificationCenter.default.removeObserver(self)
        self.performSegue(withIdentifier: "goToEvents", sender: sender)
        
    }
    
    

}
