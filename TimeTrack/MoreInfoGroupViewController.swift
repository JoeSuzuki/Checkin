//
//  MoreInfoGroupViewController.swift
//  TimeTrack
//
//  Created by Joe Suzuki on 8/4/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit
import Firebase

class MoreInfoGroupViewController: UIViewController {
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
    @IBOutlet weak var descriptionLabelSecon: UILabel!
    @IBOutlet weak var counterLabelSecon: UILabel!
    @IBOutlet weak var idLabelView: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        mainNameLabelSecon.text = Constants.groupsName.myStrings
        addressLabelSecon.text = Constants.groupsLocation.myStrings
        counterLabelSecon.text = String(Constants.numberOfCheckIns.myInts)
        idLabelView.text = Constants.idd.myStrings
        descriptionLabelSecon.text = Constants.description.myStrings
        // mainImageViewSecon.layer.masksToBounds = false
        mainImageViewSecon.image = photo
        mainImageViewSecon.layer.cornerRadius = mainImageViewSecon.frame.size.width/2
        mainImageViewSecon.contentMode = UIViewContentMode.scaleAspectFill
        mainImageViewSecon.layer.masksToBounds = false
        mainImageViewSecon.clipsToBounds = true
        let membersRef = Database.database().reference().child("Members of Groups").child(Constants.idd.myStrings)
        membersRef.observe(.value, with: {
            (snapshot) in
            let value = snapshot.value as! [String: AnyObject]
            self.editer = value["Owner"] as! String
            print(self.editer)
            print(self.userID!)
        })
        print("Please Apple? ")
    }

    @IBAction func settingsButton(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "settings", sender: sender)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func checkInButton(_ sender: UIButton) {
        print(self.editer)
        print(self.userID)
        if self.editer == self.userID {
            self.performSegue(withIdentifier: "time", sender: sender)// owner
        } else {
            self.performSegue(withIdentifier: "joinerTime", sender: sender)// joiner
        }
    }
}



