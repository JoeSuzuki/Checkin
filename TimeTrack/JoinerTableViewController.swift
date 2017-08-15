//
//  JoinerTableViewController.swift
//  TimeTrack
//
//  Created by Joe Suzuki on 8/15/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit
import Firebase

struct JoinTimesData {
    let cell: Int!
    let named: String?
    let timed: String?
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
    var arrayOfTime = [JoinTimesData](){
        didSet{
            timeTable.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        timeRef = Database.database().reference().child("time info").child(Constants.idd.myStrings)
        ref = Database.database().reference().child("time info").child(Constants.idd.myStrings)
        setUp()
        currentTime()
        print(startHour)

        //configureDatabase()
        //    self.arrayOfTime.append(TimesData(cell : 1, named : "", timed : time))
        // self.clearsSelectionOnViewWillAppear = false
        timeTable.reloadData()
        startTime = "\(TimeConverter(startHour, mD: startAmpm)):\(startMin)"
        endTime = "\(TimeConverter(endHour, mD: endAmpm)):\(endMin)"
        print(startTime)
        print(endTime)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBOutlet weak var item: UINavigationItem!
    
    @IBAction func joinButton(_ sender: UIBarButtonItem) {
        let min = Date()
        let max = Date().addingTimeInterval(60 * 60 * 24 * 4)
        let picker = DateTimePicker.show(minimumDate: min, maximumDate: max)
        picker.highlightColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 138.0/255.0, alpha: 1)
        picker.darkColor = UIColor.darkGray
        picker.doneButtonTitle = "!! DONE DONE !!"
        picker.todayButtonTitle = "Today"
        picker.is12HourFormat = true
        picker.dateFormat = "hh:mm aa dd/MM/YYYY"
        //        picker.isDatePickerOnly = true
        picker.completionHandler = { date in
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm aa dd/MM/YYYY"
            self.item.title = formatter.string(from: date)
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
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfTime.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if arrayOfTime[indexPath.row].cell == 1 {
            let cell = Bundle.main.loadNibNamed("GroupTimeTableViewCell", owner: self, options: nil)?.first as! GroupTimeTableViewCell
            cell.timeLabel.text = arrayOfTime[indexPath.row].timed
            cell.nameLabel.text = arrayOfTime[indexPath.row].named
            return cell
        } else {
            let cell = Bundle.main.loadNibNamed("GroupTimeTableViewCell", owner: self, options: nil)?.first as! GroupTimeTableViewCell
            cell.timeLabel.text = arrayOfTime[indexPath.row].timed
            cell.nameLabel.text = arrayOfTime[indexPath.row].named
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
