//
//  DetailsViewController.swift
//  TimeTrack
//
//  Created by Joe Suzuki on 7/28/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit
import Firebase

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextView!
    
    // hides keyboard
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    // hides keyboard when pressing return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        groupNameTextField.resignFirstResponder()
        descriptionTextField.resignFirstResponder()
        return(true)
    }
    
    var ref: DatabaseReference!
    let userID = Auth.auth().currentUser!.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference().child("users").child(userID).child("groups").child("personal groups").childByAutoId()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addButton(_ sender: UIButton) {
//        self.ref?.child("group name").updateChildValues(["name": groupNameTextField.text as Any])
//        self.ref?.child("description").updateChildValues(["description": descriptionTextField.text as Any])
        Constants.name.myStrings = ["name": groupNameTextField.text as
            Any as! String]
        Constants.description.myStrings = ["description": descriptionTextField.text as Any as! String]
        performSegue(withIdentifier: "groupSegue", sender: self)

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    //self.ref?.child("users").child(userID).child("groups").child("personal groups").childByAutoId().updateChildValues(["address": searchTextField.text])
    //self.ref?.child("users").child(userID).child("groups").updateChildValues(["personal groups": "ppppp"])
    


}
