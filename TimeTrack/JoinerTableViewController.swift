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

struct JoinTimesData {
    let cell: Int!
    let named: String?
    let timed: String?
    let DM : String?
}

class JoinerTableViewController: UITableViewController {
    @IBOutlet var timeTable: UITableView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    var ref: DatabaseReference?
    var timeRef: DatabaseReference?
    let userID = Auth.auth().currentUser?.uid
    var timeInterval = 1
    var startHour: Int = 0
    var startMin: Int = 0
    var startAmpm: String = ""
    var endHour: Int = 0
    var endMin: Int = 0
    var endAmpm: String = ""
    var startTime: String = ""
    var endTime: String = ""
    var hourContainer = [Int]()
    var minContainer = [Int]()
    var arrayOfTime = [JoinTimesData](){
        didSet{
            timeTable.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        timeTable.reloadData()
        timeRef = Database.database().reference().child("time info").child(Constants.idd.myStrings)
        ref = Database.database().reference().child("time info").child(Constants.idd.myStrings)
        currentTime()
        setUp{ success in
            if success{
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
                            break
                        }
                    }
                    if nextStepMin >= 60 {
                        while nextStepMin >= 60 {
                            nextStepMin -= 60
                            nextStepHour += 1
                        }
                    }
                    if nextStepHour + hourAdded < endHour || nextStepMin + minutesAdded < endMin {
                        nextStepHour +=  timeIntHour as! Int
                        nextStepMin += timeIntMin as! Int
                        if nextStepMin >= 60 {
                            while nextStepMin >= 60 {
                                nextStepMin -= 60
                                nextStepHour += 1
                            }
                        }
                        print(nextStepMin)
                        print(nextStepHour)
                        hourContainer.append(nextStepHour)
                        minContainer.append(nextStepMin)
                        timeRef?.updateChildValues(["Hour":hourContainer])
                        timeRef?.updateChildValues(["Minute":minContainer])
                    } else {
                        break
                    }
                }
            }
            else{
                print("broke")
            }
        }
    }
//    override func viewDidAppear(_ animated: Bool) {
//        
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBOutlet weak var item: UINavigationItem!
    
    @IBAction func joinButton(_ sender: UIBarButtonItem) {
//        let min = Date()
//        let max = Date().addingTimeInterval(60 * 60 * 24 * 4)
//        let picker = DateTimePicker.show(minimumDate: min, maximumDate: max)
//        picker.highlightColor = UIColor(red: 90/255, green: 200/255, blue: 250/255, alpha: 1)
//        picker.darkColor = UIColor.darkGray
//        picker.doneButtonTitle = "Check In!"
//        picker.todayButtonTitle = "Today"
//        picker.is12HourFormat = true
//        picker.dateFormat = "hh:mm aa dd/MM/YYYY"
//        //        picker.isDatePickerOnly = true
//        picker.completionHandler = { date in
//            let formatter = DateFormatter()
//            let alert = SCLAlertView()
//            _ = alert.showSuccess(kSuccessTitleddd, subTitle: kSubtitlddddd)
//            formatter.dateFormat = "hh:mm aa dd/MM/YYYY"
//            self.item.title = formatter.string(from: date)
//        }
        timeSetup()
    }
    func timeSetup(){
        print("hello")
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
                    break
                }
            }
            if nextStepMin >= 60 {
                while nextStepMin >= 60 {
                    nextStepMin -= 60
                    nextStepHour += 1
                }
            }
            if nextStepHour + hourAdded < endHour || nextStepMin + minutesAdded < endMin {
            nextStepHour +=  timeIntHour as! Int
            nextStepMin += timeIntMin as! Int
                if nextStepMin >= 60 {
                    while nextStepMin >= 60 {
                        nextStepMin -= 60
                        nextStepHour += 1
                    }
                }
            print(nextStepMin)
            print(nextStepHour)
            hourContainer.append(nextStepHour)
            minContainer.append(nextStepMin)
            timeRef?.child("Hour").updateChildValues(["Hour":hourContainer])
            timeRef?.child("Minute").updateChildValues(["Minute":minContainer])
            } else {
            break
            }
        }
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

    func TimeConverter(_ startTime: Int, mD: String) -> Int{
        var newTime: Int = 1
        if mD == "PM" {
            newTime = startTime - 12
        } else {
        newTime = startTime
        }
        print(newTime)
        return newTime
    }
    func colorChange(_ textLabel: UILabel) {
        if textLabel.text == "available" {
            textLabel.textColor = UIColor(red: 90/255, green: 200/255, blue: 250/255, alpha: 1)
        } else if textLabel.text == "closed"{
            textLabel.textColor = UIColor(red: 255/255, green: 16/255, blue: 31/255, alpha: 1)
        } else  if textLabel.text == "unavailable" {
            textLabel.textColor = UIColor(red: 255/255, green: 16/255, blue: 31/255, alpha: 1)
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
    
    func setUp(completion: (Bool) -> ()){
        ref?.observe(DataEventType.value, with: {
            (snapshot) in
            let value = snapshot.value as! [String: AnyObject]
            let timeInt = value["timeInt"] as? Int
            // let checkin = value["check-in"] as? Array
            self.timeInterval = timeInt!
        })
        timeRef = Database.database().reference().child("time info").child(Constants.idd.myStrings)
        print(Constants.idd.myStrings)
        timeRef?.child("timeOpen").observe(DataEventType.value, with: {
            (snapshot) in
            let value = snapshot.value as! NSArray
            let hour = value[0] as? Int
            let min = value[1] as? Int
            let Apm = value[2] as? String
            self.startHour = hour!
            self.startMin = min!
            self.startAmpm = Apm!
            self.arrayOfTime.insert(JoinTimesData(cell : 1, named : "available", timed : "\(self.TimeConverter(self.startHour, mD: self.startAmpm)):\(self.startMin)", DM: self.startAmpm), at:0)
        })
        timeRef?.child("timeCloses").observe(DataEventType.value, with: {
            (snapshot) in
            let value = snapshot.value as! NSArray
            let hours = value[0] as? Int
            let mins = value[1] as? Int
            let Apms = value[2] as? String
            self.endHour = hours!
            self.endMin = mins!
            self.endAmpm = Apms!
            self.arrayOfTime.append(JoinTimesData(cell : 1, named : "closed", timed : "\(self.TimeConverter(self.endHour, mD: self.endAmpm)):\(self.endMin)", DM: self.endAmpm))
//            completion(true)
        })
        completion(true)
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
            cell.DM.text = arrayOfTime[indexPath.row].DM
            colorChange(cell.nameLabel)
            
            return cell
        } else {
            let cell = Bundle.main.loadNibNamed("GroupTimeTableViewCell", owner: self, options: nil)?.first as! GroupTimeTableViewCell
            cell.timeLabel.text = arrayOfTime[indexPath.row].timed
            cell.nameLabel.text = arrayOfTime[indexPath.row].named
            cell.DM.text = arrayOfTime[indexPath.row].DM
            colorChange(cell.nameLabel)
            return cell
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if arrayOfTime[indexPath.row].cell == 1 {
            return 60
        } else {
            return 60
        }
    }
}
