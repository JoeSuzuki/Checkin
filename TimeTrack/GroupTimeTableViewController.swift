//
//  GroupTimeTableViewController.swift
//  TimeTrack
//
//  Created by Joe Suzuki on 8/9/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit
import Firebase

struct TimesData {
    let cell: Int!
    let named: String?
    let timed: String?
}

class GroupTimeTableViewController: UITableViewController {
    var arrayOfTime = [TimesData](){
        didSet{
            timeTable.reloadData()
        }
    }
    
    @IBOutlet var timeTable: UITableView!
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

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        //configureDatabase()
        ref = Database.database().reference().child("time info").child(Constants.idd.myStrings)
     //    self.arrayOfTime.append(TimesData(cell : 1, named : "", timed : time))
        
    }
    func setUp() {
        ref?.observe(DataEventType.value, with: {
            (snapshot) in
            let value = snapshot.value as! [String: AnyObject]
            let timeInt = value["timeInt"] as? Int
           // let checkin = value["check-in"] as? Array
            self.timeInterval = timeInt!
        })
//        timeRef = Database.database().reference().child("time info").child(Constants.idd.myStrings)
//        timeRef?.child("timeCloses").observe(DataEventType.value, with: {
//            (snapshot) in
//            let value = snapshot.value as! [String: AnyObject]
//            let hours = value["0"] as? Int
//            let mins = value["1"] as? Int
//            let Apms = value["2"] as? String
//            self.endHour = hours!
//            self.endMin = mins!
//            self.endAmpm = Apms!
//        })
//        timeRef?.child("timeOpen").observe(DataEventType.value, with: {
//            (snapshot) in
//            let value = snapshot.value as! [String: AnyObject]
//            let hour = value["0"] as? Int
//            let min = value["1"] as? Int
//            let Apm = value["2"] as? String
//            self.startHour = hour!
//            self.startMin = min!
//            self.startAmpm = Apm!
//        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
//

