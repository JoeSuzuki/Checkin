//
//  JoinGroupViewController.swift
//  TimeTrack
//
//  Created by Joe Suzuki on 8/5/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit
import Firebase
import SCLAlertView

let kSuccessTitle = "Congratulations"
let kErrorTitle = "Connection error"
let kNoticeTitle = "Notice"
let kWarningTitle = "Opps"
let kInfoTitle = "Info"
let kSubtitle = "The passcode you entered is incorrect"
let kSubtitld = "You joined a group!"

let kDefaultAnimationDuration = 2.0

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
                let alert = SCLAlertView()
                _ = alert.showSuccess(kSuccessTitle, subTitle: kSubtitld)
                break
            } else {
                let membersRef = Database.database().reference().child("Members of Groups")
                _ = SCLAlertView().showError("Opps!", subTitle:"Your passcode seems to not be correct. ", closeButtonTitle:"OK")
                break
            }
            
        }
    }
}
//
//let membersRef = Database.database().reference().child("Members of Groups")
//_ = SCLAlertView().showError("Opps!", subTitle:"Your passcode seems to not be correct. ", closeButtonTitle:"OK")
