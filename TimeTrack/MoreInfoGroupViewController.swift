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
    var timeInterval = 1
    var startHour: Int = 0
    var startMin: Int = 0
    var startAmpm: String = ""
    var endHour: Int = 0
    var endMin: Int = 0
    var endAmpm: String = ""
    var startTime: String = ""
    var endTime: String = ""
    var timeContainer = [String]()
    var hourContainer = [Int]()
    var minContainer = [Int]()
    var keysArray = [String]()
    var valuesArray = [String]()
    var organizeTime = [String]()
    var newItems = [DataSnapshot]()
    var fullName = ""
    var editer: String = ""

    @IBOutlet weak var mainImageViewSecon: UIImageView!
    @IBOutlet weak var mainNameLabelSecon: UILabel!
    @IBOutlet weak var addressLabelSecon: UILabel!
    @IBOutlet weak var counterLabelSecon: UILabel!
    @IBOutlet weak var idLabelView: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        mainNameLabelSecon.text = Constants.groupsName.myStrings
        addressLabelSecon.text = Constants.groupsLocation.myStrings
        counterLabelSecon.text = String(Constants.numberOfCheckIns.myInts)
        idLabelView.text = Constants.idd.myStrings
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
//        edit{
//            print("nice apple")
//        }
        print("Please Apple? ")
    }
//    func edit(completion: () -> ()) {
//        ref = Database.database().reference().child("personal groups info").child(userID!)
//        ref?.child(idLabelView.text!).observe(.childAdded, with: {
//            (snapshot) in
//            let value = snapshot.value as! [String: AnyObject]
//            let edit = value["edit"] as? String
//            self.editer = edit!
//            
//        })
//        completion()
//    }
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


    //     func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        let JoinerTimeJoinTableViewController = segue.destination as! JoinerTimeJoinTableViewController
//        Constants.idd.myStrings = idLabelView.text!
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

