//
//  AddGroupsViewController.swift
//  TimeTrack
//
//  Created by Joe Suzuki on 7/25/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit

class AddGroupsViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    @IBAction func CreateButton(_ sender: UIButton) {
        performSegue(withIdentifier: "create", sender: self)
    }
 
}
