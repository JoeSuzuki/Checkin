//
//  JoinerTableViewController.swift
//  TimeTrack
//
//  Created by Joe Suzuki on 8/15/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//
import UIKit
import Firebase
import SCLAlertView
let kSuccessTitleddd = "Awesome!"
let kErrorTitledddd = "Connection error"
let kNoticeTitledddd = "Notice"
let kWarningTitledddd = "Opps"
let kInfoTitledddd = "Info"
let kSubtitledddd = "The passcode you entered is incorrect"
let kSubtitlddddd = "You Checked in!"

//while OpenHour + HourInterval < endHour || OpenMin + MinInterval < endMin{
//    if OpenHour +  HourInterval == endHour {
//        if OpenMin + MinInterval < endMin {
//            if OpenMin >= 60 {
//                while OpenMin >= 60 {
//                    OpenMin -= 60
//                    OpenHour += 1
//                }
//            }
//            OpenHour +=  HourInterval
//            OpenMin += MinInterval
//        }
//    }
//    if OpenHour + HourInterval < endHour || OpenMin + MinInterval < endMin {
//        OpenHour +=  HourInterval
//        OpenMin += MinInterval
//        if OpenMin >= 60 {
//            while OpenMin >= 60 {
//                OpenMin -= 60
//                OpenHour += 1
//            }
//        }
//    }
struct JoinTimesData {
    let cell: Int!
    let named: String?
    let timed: String?
}

class JoinerTableViewController: UITableViewController{
    @IBOutlet var timeTable: UITableView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
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
    var arrayOfTime = [JoinTimesData](){
        didSet{
            timeTable.reloadData()
        }
    }
    var organizeTime = [String]()
    var newItems = [DataSnapshot]()
    var fullName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        arrayOfTime = []
        timeTable.delegate = self
        timeTable.dataSource = self
        timeRef = Database.database().reference().child("time info").child(Constants.idd.myStrings)
        ref = Database.database().reference().child("time info").child(Constants.idd.myStrings)
        currentTime()
        number { () in
            print("nice")
        }
        firstButton()
        self.organize()
        timeTable.reloadData()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
        self.organize()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBOutlet weak var item: UINavigationItem!
    @IBAction func joinButton(_ sender: UIBarButtonItem) {
        setUp{ () in
            self.timeSetup { () in
                self.organize()
//                self.number { () in
//                    print("nice")
//                }
            }
        }
    }
    func setUp(completion: () -> ()){
        timeRef = Database.database().reference().child("time info").child(Constants.idd.myStrings)
        timeRef?.child("timeCloses").observe(DataEventType.value, with: {
            (snapshot) in
            let value = snapshot.value as! NSArray
            let hours = value[0] as? Int
            let mins = value[1] as? Int
            let Apms = value[2] as? String
            self.endHour = hours!
            self.endMin = mins!
            self.endAmpm = Apms!
            
        })
        timeRef?.child("timeOpen").observe(DataEventType.value, with: {
            (snapshot) in
            let value = snapshot.value as! NSArray
            let hours = value[0] as? Int
            let mins = value[1] as? Int
            let Apms = value[2] as? String
            self.startHour = hours!
            self.startMin = mins!
            self.startAmpm = Apms!
            
        })
        ref?.observe(DataEventType.value, with: {
            (snapshot) in
            let value = snapshot.value as! [String: AnyObject]
            let timeInt = value["timeInt"] as? Int
            // let checkin = value["check-in"] as? Array
            self.timeInterval = timeInt!
        })
        print("setup works!")
        completion()

    }
    
    func timeSetup(completion: () -> ()){
        
        timeRef = Database.database().reference().child("time info").child(Constants.idd.myStrings)
        var OpenHour = startHour
        var OpenMin = startMin
        let timeIntHour = timeIntervalChange(timeInterval)[0]
        let timeIntMin = timeIntervalChange(timeInterval)[1]
        let MinInterval = timeIntMin as! Int // min Interval
        let HourInterval = timeIntHour as! Int // hour Interval
        
        while OpenHour < endHour {
            if OpenHour + HourInterval == endHour && OpenMin + MinInterval < endMin {
                while OpenHour + HourInterval == endHour && OpenMin + MinInterval < endMin {
                    OpenHour += HourInterval
                    OpenMin += MinInterval
                    print("startHour + changeHour: \(OpenHour)")
                    print("startMin + changeMin: \(OpenMin)")
                    timeDevolve(timeCreator(OpenHour, OpenMin))
                }
            } else if OpenHour + HourInterval < endHour && OpenMin + MinInterval < endMin{
                if OpenHour + HourInterval < endHour && OpenMin + MinInterval < endMin {
                    while OpenHour + HourInterval < endHour && OpenMin + MinInterval < endMin {
                        OpenHour += HourInterval
                        OpenMin += MinInterval
                        print("startHour + changeHour: \(OpenHour)")
                        print("startMin + changeMin: \(OpenMin)")
                        timeDevolve(timeCreator(OpenHour, OpenMin))
                    }
                }
            } else if OpenHour + HourInterval <= endHour {
                var tempHour = 0
                var tempStartMin = OpenMin + MinInterval
                var tempMin = 0
                while OpenMin + MinInterval >= 60 {
                    tempStartMin -= 60
                    tempHour += 1
                    tempMin = tempStartMin
                }
                if OpenHour + HourInterval + tempHour <= endHour && OpenMin + MinInterval + tempMin <= endMin {
                    OpenHour += HourInterval
                    OpenMin += MinInterval
                }
            }
        }
        completion()
        
    }
    
    
    func organize() {
        arrayOfTime = []
        timeRef = Database.database().reference().child("time info").child(Constants.idd.myStrings)
        timeRef?.child("AM").observeSingleEvent(of: .value, with: {
            (snapshot) in
            guard let snapshotArray = snapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            for snapshotItem in snapshotArray {
                let key = snapshotItem.key
                let value = snapshotItem.value
                if key == (self.timeCreator(self.endHour, self.endMin)){
                    self.arrayOfTime.insert(JoinTimesData(cell : 1, named : "closed", timed : "\(self.timeCreator(self.endHour, self.endMin))"), at:self.arrayOfTime.count)
                } else {
                    if value as! String == ""{
                        self.arrayOfTime.append(JoinTimesData(cell: 1, named: "available", timed: key as! String))
                    } else {
                        self.arrayOfTime.insert(JoinTimesData(cell : 1, named : value as! String, timed : key as! String), at:0)
                    }
                }
            }
        })
        timeRef?.child("PM").observeSingleEvent(of: .value, with: {
            (snapshot) in
            guard let snapshotArray = snapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            for snapshotItem in snapshotArray {
                let key = snapshotItem.key
                let value = snapshotItem.value
                if key == (self.timeCreator(self.endHour, self.endMin)){
                    self.arrayOfTime.insert(JoinTimesData(cell : 1, named : "closed", timed : "\(self.timeCreator(self.endHour, self.endMin))"), at:self.arrayOfTime.count)
                } else {
                    if value as! String == ""{
                        self.arrayOfTime.append(JoinTimesData(cell: 1, named: "available", timed: key as! String))
                    } else {
                        self.arrayOfTime.insert(JoinTimesData(cell : 1, named : value as! String, timed : key as! String), at:0)
                    }
                }
            }
        })
    }
    
    func timeDevolve(_ stringTime: String) {// writes to firebase AM and PM times per interval
        timeRef = Database.database().reference().child("time info").child(Constants.idd.myStrings)
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
    
    func currentTime() {
        let date = Date()
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        //print ("\(hour):\(minutes)")
        
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        // print("\(day).\(month)")
    }
    
    
    func colorChange(_ textLabel: UILabel) {
        if textLabel.text == "available" {
            textLabel.textColor = UIColor(red: 90/255, green: 200/255, blue: 250/255, alpha: 1)
        } else if textLabel.text == "closed"{
            textLabel.textColor = UIColor(red: 255/255, green: 16/255, blue: 31/255, alpha: 1)
        } else  if textLabel.text == "unavailable" {
            textLabel.textColor = UIColor(red: 255/255, green: 16/255, blue: 31/255, alpha: 1)
        } else {
            textLabel.textColor = UIColor(red: 253/255, green: 229/255, blue: 16/255, alpha: 1)
        }
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
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfTime.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if arrayOfTime[indexPath.row].cell == 1 {
            let cell = Bundle.main.loadNibNamed("GroupTimeTableViewCell", owner: self, options: nil)?.first as! GroupTimeTableViewCell
            cell.timeLabel.text = arrayOfTime[indexPath.row].timed
            cell.nameLabel.text = arrayOfTime[indexPath.row].named
            colorChange(cell.nameLabel)
            return cell
        } else {
            let cell = Bundle.main.loadNibNamed("GroupTimeTableViewCell", owner: self, options: nil)?.first as! GroupTimeTableViewCell
            cell.timeLabel.text = arrayOfTime[indexPath.row].timed
            cell.nameLabel.text = arrayOfTime[indexPath.row].named
            colorChange(cell.nameLabel)
            return cell
        }
    }
    var usernameLabel = User.current.username
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if arrayOfTime[indexPath.row].cell == 1 {
            return 60
        } else {
            return 60
        }
    }
    
    func firstButton() -> String { // return first and last name of the user
        userPath = Database.database().reference().child("users").child(userID!)
        userPath?.observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let first = value?["firstName"] as? String
            let last = value?["lastName"] as? String
            self.fullName = first! + " " + last!
        })
        return self.fullName
    }
    var totalAmountAm = [String]()
    var totalAmountPm = [String]()
    
    func number(completion: () -> ()) {
        timeRef = Database.database().reference().child("time info").child(Constants.idd.myStrings)
        timeRef?.child("AM").observeSingleEvent(of: .value, with: {
            (snapshot) in
            guard let snapshotArray = snapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            for snapshotItem in snapshotArray {
                let value = snapshotItem.value
                self.totalAmountPm.append(value as! String)
            }
        })
        timeRef?.child("PM").observeSingleEvent(of: .value, with: {
            (snapshot) in
            guard let snapshotArray = snapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            for snapshotItem in snapshotArray {
                let value = snapshotItem.value
                self.totalAmountPm.append(value as! String)
            }
        })
        completion()
    }
    func timeDevolver(_ stringTime: String) -> String{
        let seperatedTimeList = stringTime.components(separatedBy: " ")
        let stringDm = seperatedTimeList[1]
        let beggining = seperatedTimeList[0]
        if stringDm == "AM" {
            return "AM"
        } else if stringDm == "PM" {
            timeRef?.child("PM").updateChildValues([stringTime: ""])
            return "PM"
        } else {
            return "AM"
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! GroupTimeTableViewCell
        //        number { () in
        //
        //        for each in totalAmountAm {
        //            if each == usernameLabel {
        //                SCLAlertView().showInfo("You have a spot!", subTitle: "You can only occupy one spot.")
        //                break
        //            }
        //        }
        //        for each in totalAmountPm {
        //            if each == usernameLabel {
        //                SCLAlertView().showInfo("You have a spot!", subTitle: "You can only occupy one spot.")
        //                break
        //            }
        //
        //        }
        //        }
        if cell.nameLabel.text == "available" {
            let alert = SCLAlertView()
            _ = alert.addButton("Join") {
                self.timeRef = Database.database().reference().child("time info").child(Constants.idd.myStrings)
                self.timeRef?.child(self.timeDevolver(cell.timeLabel.text!)).updateChildValues([cell.timeLabel.text! : self.usernameLabel ])
                self.organize()
                //self.timeTable.reloadData()
            }
            _ = alert.showInfo("Check-In", subTitle: "Are you sure you want to check in to the time you selected?")
        } else if cell.nameLabel.text == "closed"{
            SCLAlertView().showInfo("Unavailable", subTitle: "This location closes at this time, please select a different time.")
        } else if cell.nameLabel.text == usernameLabel {
            let alert = SCLAlertView()
            _ = alert.addButton("Leave") {
                self.timeRef = Database.database().reference().child("time info").child(Constants.idd.myStrings)
                self.timeRef?.child(self.timeDevolver(cell.timeLabel.text!)).updateChildValues([cell.timeLabel.text! : "" ])
                self.organize()
                //self.timeTable.reloadData()
            }
            _ = alert.showInfo("Leave?", subTitle: "Are you sure you want to leave time you selected?")
        } else {
            SCLAlertView().showInfo("Unavailable", subTitle: "This time has been taken, please select a different time.")
        }
    }
}
