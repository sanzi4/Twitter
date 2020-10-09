//
//  LoginViewController.swift
//  Twitter
//
//  Created by Sanzida Sultana on 10/8/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("The user view screen appeared")
        if(UserDefaults.standard.bool(forKey: "LoggedIn") == true){
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }
    }
 
    // Checks user login credientals
    @IBAction func userLogin(_ sender: Any) {
        
        print("User Logged in")
        UserDefaults.standard.set(true, forKey: "LoggedIn")
        TwitterAPICaller.client?.login(url: "https://api.twitter.com/oauth/request_token", success: {
            self.performSegue(withIdentifier: "loginToHome", sender: self)
        }, failure: { (Error) in
            print("Couldn't Login in")
        })
    }
}
