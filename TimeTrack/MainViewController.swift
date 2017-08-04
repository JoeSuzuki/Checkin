//
//  MainViewController.swift
//  Firebase-boilerplate
//
//  Created by Mariano Montori on 7/24/17.
//  Copyright © 2017 Mariano Montori. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class MainViewController: UIViewController {

    var authHandle: AuthStateDidChangeListenerHandle?
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = "\(User.current.firstName) \(User.current.lastName)"
        usernameLabel.text = User.current.username
        
        authHandle = AuthService.authListener(viewController: self)
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImage.clipsToBounds = true
    

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        AuthService.removeAuthListener(authHandle: authHandle)
    }
    func logout() {
        AuthService.presentLogOut(viewController: self)
    }
    func deleteAccount() {
        guard let user = Auth.auth().currentUser else {
            print("NO USER EXISTS???")
            return
        }
        AuthService.presentDelete(viewController: self, user : user)
    }

    @IBAction func settingButton(_ sender: UIBarButtonItem) {
        
        // create the alert
        let alert = UIAlertController(title: "Leaving?", message: "Would you like to logout or delete your account completely?", preferredStyle: UIAlertControllerStyle.alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Log Out", style: UIAlertActionStyle.destructive, handler: { action in
            self.logout()
        }))
        alert.addAction(UIAlertAction(title: "Delete Account", style: UIAlertActionStyle.destructive, handler: { action in
            self.deleteAccount()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))

        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
}
