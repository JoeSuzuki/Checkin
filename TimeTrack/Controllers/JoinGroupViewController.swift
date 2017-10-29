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
    var ownerIds: [String] = []
    var ref: DatabaseReference!
    var ownerRefs: DatabaseReference?
    var groupRef: DatabaseReference?
    var groupsRef: DatabaseReference?
    let userID = Auth.auth().currentUser!.uid
    
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard)))
        ref = Database.database().reference().child("global groups info").child(userID)
        let groupsRef = Database.database().reference().child("groupsIds")
        groupsRef.queryOrderedByKey().observe(.childAdded, with: {
            (snapshot) in
            let value = snapshot.value as! String
    //     let key = value["key"] as? String
            self.childIds.append(value)
            //print(self.childIds)
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
        for key in self.childIds {
            print(key)
            if self.passwordTextField.text! == key {
                let userPath = Database.database().reference().child("users").child(userID)
                userPath.child("joined").child(key).updateChildValues(["key" : key])
                let membersRef = Database.database().reference().child("Members of Groups").child(key)
                groupsRef?.queryOrderedByKey().observe(.childAdded, with: {
                    (snapshot) in
                    
                    let value = snapshot.value as! String
                    //     let key = value["key"] as? String
                    self.childIds.append(value)
                    //print(self.childIds)
                })
                membersRef.child("joiner").updateChildValues([userID: userID])
                let reff = Database.database().reference().child("personal groups info").child(userID).child(key)

//                var count: Int = 0
//                membersRef.child("joiner").observe(.value, with: { (snapshot: DataSnapshot!) in
//                    //print(snapshot.childrenCount)
//                    count = Int(snapshot.childrenCount)
//                    reff.updateChildValues(["numOfMembers": count + 1])
//                })
                let initialViewController = UIStoryboard.initialViewController(for: .main)
                self.view.window?.rootViewController = initialViewController
                self.view.window?.makeKeyAndVisible()
                let alert = SCLAlertView()
                _ = alert.showSuccess(kSuccessTitle, subTitle: kSubtitld)
                return
            } else {
                let membersRef = Database.database().reference().child("Members of Groups")
            }
        }
        _ = SCLAlertView().showError("Opps!", subTitle:"Your passcode seems to not be correct. ", closeButtonTitle:"OK")
    }
}
//
//let membersRef = Database.database().reference().child("Members of Groups")
//_ = SCLAlertView().showError("Opps!", subTitle:"Your passcode seems to not be correct. ", closeButtonTitle:"OK")
