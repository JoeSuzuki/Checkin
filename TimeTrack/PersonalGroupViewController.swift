//
//  PersonalGroupViewController.swift
//  TimeTrack
//
//  Created by Joe Suzuki on 7/28/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit
import Firebase

class PersonalGroupViewController: UIViewController{

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var daysOpen: UILabel!

    var ref: DatabaseReference!
    let userID = Auth.auth().currentUser!.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference().child("groups").child(userID).childByAutoId()
        self.ref?.child("location").updateChildValues(Constants.location.myStrings)
        self.ref?.child("from").updateChildValues(Constants.from.myStrings)
        self.ref?.child("to").updateChildValues(Constants.to.myStrings)
        self.ref?.child("name").updateChildValues(Constants.name.myStrings)
        self.ref?.child("description").updateChildValues(Constants.description.myStrings)
        descriptionLabel.text = Constants.description.myStrings["description"]
        addressLabel.text = Constants.location.myStrings["location"]
        let days = "\(String(describing: Constants.from.myStrings["from"])) - \(String(describing: Constants.to.myStrings["to"]))"
        daysOpen.text = days
        groupNameLabel.text = Constants.name.myStrings["name"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func leaveButton(_ sender: UIButton) {
        let initialViewController = UIStoryboard.initialViewController(for: .main)
        self.view.window?.rootViewController = initialViewController
        self.view.window?.makeKeyAndVisible()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
