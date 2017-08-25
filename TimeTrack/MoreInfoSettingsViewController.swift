//
//  MoreInfoSettingsViewController.swift
//  TimeTrack
//
//  Created by Joe Suzuki on 8/24/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//
import UIKit
import Firebase
import SCLAlertView
import Kingfisher
import FirebaseAuth

class MoreInfoSettingsViewController: UITableViewController {
    var ref: DatabaseReference?
    var timeRef: DatabaseReference?
    let userID = Auth.auth().currentUser?.uid
    var userPath: DatabaseReference?
    var newItems = [DataSnapshot]()
    var fullName = ""
    var editer: String = ""
    
    @IBOutlet weak var mainImageViewSecon: UIImageView!
    @IBOutlet weak var mainNameLabelSecon: UILabel!
    @IBOutlet weak var addressLabelSecon: UILabel!

    @IBOutlet weak var mainDescriptionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        mainNameLabelSecon.text = Constants.groupsName.myStrings
        addressLabelSecon.text = Constants.groupsLocation.myStrings
        mainDescriptionLabel.text = Constants.description.myStrings
        // mainImageViewSecon.layer.masksToBounds = false
        mainImageViewSecon.image = photo
        mainImageViewSecon.layer.cornerRadius = mainImageViewSecon.frame.size.width/2
        mainImageViewSecon.contentMode = UIViewContentMode.scaleAspectFill
        mainImageViewSecon.layer.masksToBounds = false
        mainImageViewSecon.clipsToBounds = true
}
    @IBAction func deleteButton(_ sender: UIButton) {
        timeRef?.child("time info").child(Constants.idd.myStrings).setValue(nil)
        ref?.child("Members of Groups").child(Constants.idd.myStrings).setValue(nil)
        ref?.child("Members of Groups").child(Constants.idd.myStrings).setValue(nil)
        ref?.child("groupsIds").child(Constants.idd.myStrings).setValue(nil)
        ref?.child("ownerIds").child(Constants.idd.myStrings).setValue(nil)
    }
    
}
