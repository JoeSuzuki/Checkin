//
//  LoginViewController.swift
//  TimeTrack
//
//  Created by Joe Suzuki on 7/24/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseAuthUI
import FirebaseDatabase

typealias FIRUser = FirebaseAuth.User // Seperates confussion between the different "users"

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - IBActions

    @IBAction func loginButtonTaped(_ sender: UIButton) {
        // 1 access the FUIAuth default auth UI singleton
        guard let authUI = FUIAuth.defaultAuthUI()
            else { return }
        
        // 2 set FUIAuth's singleton delegate
        authUI.delegate = self
        
        // 3 present the auth view controller
        let authViewController = authUI.authViewController()
        present(authViewController, animated: true)
    }
    
}
extension LoginViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUser?, error: Error?) {
//        if let error = error {
//            assertionFailure("Error signing in: \(error.localizedDescription)")
//            return
//        }
        
        // 1
        guard let user = user
            else { return }
        
        // 2
        
        UserService.show(forUID: user.uid) { (user) in
            if let user = user {
                // handle existing user
                User.setCurrent(user, writeToUserDefaults: true)
                
                let initialViewController = UIStoryboard.initialViewController(for: .main)
                self.view.window?.rootViewController = initialViewController
                self.view.window?.makeKeyAndVisible()
            } else {
                // handle new user
                self.performSegue(withIdentifier: Constants.Segue.toCreateUsername, sender: self)
            }
        }
    }
}
