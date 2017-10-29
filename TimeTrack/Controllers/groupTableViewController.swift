//
//  TableViewController.swift
//  TimeTrack
//
//  Created by Joe Suzuki on 7/26/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class groupTableViewController: UITableViewController {
    
    //let ref = Database.database().reference().child("users")
    var ref: DatabaseReference?
    let userID = Auth.auth().currentUser?.uid
    var name: [AnyObject] = []
    
    override func viewDidLoad() {
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

    
}
