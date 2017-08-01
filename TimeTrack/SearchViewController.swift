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
    let userID = Auth.auth().currentUser!.uid
    
    @IBOutlet weak var searchTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ref = Database.database().reference()
    }
    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        
//    }
//    
//    
//    //this method will return the total rows count in the table view
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//    }
    


    
   
    



}
