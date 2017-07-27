//
//  SearchViewController.swift
//  TimeTrack
//
//  Created by Joe Suzuki on 7/27/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit
import Firebase

class SearchViewController: UIViewController{
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ref = Database.database().reference()
 
    }
    @IBAction func button(_ sender: UIButton) {
        self.ref?.child("users").setValue("ikkkkkk")
    }

    
   
    



}
