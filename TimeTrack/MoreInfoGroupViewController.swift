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
        timeRef = Database.database().reference().child("time info").child(Constants.idd.myStrings)
        ref = Database.database().reference().child("time info").child(Constants.idd.myStrings)
        setUp()

    }
    func setUp(){
        ref?.observe(DataEventType.value, with: {
            (snapshot) in
            let value = snapshot.value as! [String: AnyObject]
            let timeInt = value["timeInt"] as? Int
            // let checkin = value["check-in"] as? Array
            self.timeInterval = timeInt!
        })
    }
    func timeSetup(){
        timeRef = Database.database().reference().child("time info").child(Constants.idd.myStrings)
        var nextStepHour = startHour
        var nextStepMin = startMin
        let timeIntHour = timeIntervalChange(timeInterval)[0]
        let timeIntMin = timeIntervalChange(timeInterval)[1]
        let minutesAdded = timeIntMin as! Int
        let hourAdded = timeIntHour as! Int
        
        while nextStepHour < endHour || nextStepMin < endMin {
            if nextStepHour +  hourAdded == endHour {
                if nextStepMin + minutesAdded < endMin {
                    nextStepHour +=  timeIntHour as! Int
                    nextStepMin += timeIntMin as! Int
                } else {
                    return
                }}
            if nextStepMin >= 60 {
                while nextStepMin >= 60 {
                    nextStepMin -= 60
                    nextStepHour += 1
                }}
            if nextStepHour + hourAdded < endHour || nextStepMin + minutesAdded < endMin {
                nextStepHour +=  timeIntHour as! Int
                nextStepMin += timeIntMin as! Int
                if nextStepMin >= 60 {
                    while nextStepMin >= 60 {
                        nextStepMin -= 60
                        nextStepHour += 1
                    }
                }
               // timeDevolve(timeCreator(nextStepHour, nextStepMin))
            }
        }
    }
    func timeDevolve(_ stringTime: String) {// writes to firebase AM and PM times per interval
        let seperatedTimeList = stringTime.components(separatedBy: " ")
        let stringDm = seperatedTimeList[1]
        let beggining = seperatedTimeList[0]
        if stringDm == "AM" {
            timeRef?.child("AM").updateChildValues([stringTime: ""])
        } else if stringDm == "PM" {
            timeRef?.child("PM").updateChildValues([stringTime: ""])
        }
    }
    func timeCreator(_ hour: Int, _ min: Int) -> String { // takes ints and outputs a time friendly string
        var newHour = hour
        var Dm = ""
        var stringHour = ""
        var stringMin = ""
        if newHour > 12 {
            newHour -= 12
            Dm = "PM"
            if newHour < 10{
                stringHour = "0\(newHour)"
            } else {
                stringHour = "\(newHour)"
            }
            if min < 10 {
                stringMin = "\(min)0 "
            }else {
                stringMin = "\(min) "
            }
        } else {
            Dm = "AM"
            if newHour < 10{
                stringHour = "0\(newHour)"
            } else {
                stringHour = "\(newHour)"
            }
            if min < 10 {
                stringMin = "\(min)0 "
            }else {
                stringMin = "\(min) "
            }
        }
        return stringHour + ":" + stringMin + Dm
    }
     func timeIntervalChange(_ interval: Int) -> Array<Any>{
        var hour = 0
        var g = interval
        if interval > 60 {
            while g >= 60 {
                g -= 60
                hour += 1
            }
            return [hour , g]
        } else if interval == 60 {
            var newmin = 0
            var newHour = 1
            var newTime = [newHour, newmin]
            return newTime
        } else if interval < 60 {
            return [0,interval]
        } else {
            return [0,interval]
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func checkInButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "time", sender: sender)
    }
    
     func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let groupTimeTableViewController = segue.destination as! GroupTimeTableViewController
        Constants.idd.myStrings = idLabelView.text!
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
