//
//  GroupLocationViewController.swift
//  TimeTrack
//
//  Created by Joe Suzuki on 7/28/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit
import Firebase

class GroupLocationViewController: UIViewController {

    //screen 1
    @IBOutlet weak var locationDisplay: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    
   // hides keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    // hides keyboard when pressing return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        return(true)
    }
    var ref: DatabaseReference!
    let userID = Auth.auth().currentUser!.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ref = Database.database().reference().child("users").child(userID).child("groups").child("personal groups").childByAutoId()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func locationTextField(_ sender: UITextField) {
        locationDisplay.text = searchTextField.text
        Constants.location.myStrings = ["location": searchTextField.text as Any as! String]
    }
    
    


    //self.ref?.child("users").child(userID).child("groups").child("personal groups").childByAutoId().updateChildValues(["address": searchTextField.text])
    //self.ref?.child("users").child(userID).child("groups").updateChildValues(["personal groups": "ppppp"])

   
}
