//
//  SearchViewViewController.swift
//  TimeTrack
//
//  Created by Joe Suzuki on 7/27/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit
import Firebase

class SearchViewViewController: UIViewController {

    var ref: DatabaseReference!
    let userID = Auth.auth().currentUser!.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ref = Database.database().reference()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func joinButton(_ sender: UIButton) {
    }

}
