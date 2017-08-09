//
//  JoinGroupViewController.swift
//  TimeTrack
//
//  Created by Joe Suzuki on 8/5/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit
import Firebase

class JoinGroupViewController: UIViewController {
   
    var childIds: [String] = []
    var ref: DatabaseReference!
    var groupRef: DatabaseReference?
    var groupsRef: DatabaseReference?
    let userID = Auth.auth().currentUser!.uid
    
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard)))
        ref = Database.database().reference().child("global groups info").child(userID)
        let groupRef = Database.database().reference().child("personal groups info")
        let groupsRef = Database.database().reference().child("groupsIds")
        groupsRef.queryOrderedByKey().observe(.childAdded, with: {
            (snapshot) in
            let value = snapshot.value as! String
    //     let key = value["key"] as? String
            self.childIds.append(value)
            //print(childIds)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // hides keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    // hides keyboard when pressing return
    override func dismissKeyboard() {
        passwordTextField.resignFirstResponder()
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        passwordTextField.resignFirstResponder()
        return true
    }
    @IBAction func passwordEnterButton(_ sender: UIButton) {
        let membersRef = Database.database().reference().child("Members of Groups")
        for key in self.childIds {
            if self.passwordTextField.text! == key {
                membersRef.child(key).updateChildValues([userID: userID])
            }
        }
//        groupRef.observe(.value, with: { snapshot in
//            if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
//                for child in snapshots {
//                    if passwordTextField.text! == child {
//                        print("Child: ", child)}
//                }
//            }
//        })
        
        //        let refKey = ref.key
   //     if passwordTextField.text ==
    }
    
}
