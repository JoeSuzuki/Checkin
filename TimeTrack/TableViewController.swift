//
//  TableViewController.swift
//  TimeTrack
//
//  Created by Joe Suzuki on 7/26/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import Foundation
import UIKit
import Firebase

struct cellData {
    let cell: Int!
    let text: String?
    let image: UIImage?
    let address: String?
    let numOfCheckIns: Int?
    let id: String!
    let memberTotal: Int!
}
var myIndex = 0
class TableViewController: UITableViewController {

    //let ref = Database.database().reference().child("users")
    var tableText: String?
    var tableImage: UIImage?
    var arrayOfCellData = [cellData](){
        didSet{
            groupTableView.reloadData()
        }
    }
    var ref: DatabaseReference?
    let userID = Auth.auth().currentUser?.uid
    var name: [String] = []
//    var imageName: String = ""
//    var imaged = UIImage?.self
    override func viewDidLoad() {
        super.viewDidLoad()
        //configureDatabase()
        ref = Database.database().reference().child("personal groups info").child(userID!)
        ref?.queryOrderedByKey().observe(.childAdded, with: {
            (snapshot) in
            let value = snapshot.value as! [String: AnyObject]
            let name = value["name"] as? String
            let location = value["location"] as? String
            let checkIns = value["numOfCheckIns"] as? Int
            let keyed = value["key"] as! String!
            let mem = value["numOfMembers"] as? Int
            self.arrayOfCellData.append(cellData(cell : 1, text : name , image : #imageLiteral(resourceName: "docotrsoffice"), address: location, numOfCheckIns: checkIns, id: keyed, memberTotal: mem))
        })
        let date = Date()
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        print ("\(hour):\(minutes):\(seconds)")
        
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        print("\(day).\(month)")
        let subViewOfSegment: UIView = segmentedControl.subviews[0] as UIView
        subViewOfSegment.tintColor = UIColor(red: 90/255, green: 200/255, blue: 250/255, alpha: 1)
        let subViewOfSegments: UIView = segmentedControl.subviews[1] as UIView
        subViewOfSegments.tintColor = UIColor(red: 90/255, green: 200/255, blue: 250/255, alpha: 1)
        //        self.ref?.observe(.childAdded, with: { (snapshot)  in
        //            if let result = snapshot.value as? [String : Any],
        //                // if let locationResult = snapshot.value as? [String : Any],
        //                let groupName = result["name"] as? [String : Any],
        //                let name = groupName["name"] as? String
        //            {
        //                let groupName = result["name"]
        //                self.name.append(name)
        //                self.arrayOfCellData.append(cellData(cell : 1, text : name , image : #imageLiteral(resourceName: "docotrsoffice"), address: "canal street"))
        //            }
        //        })
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentedControl.selectedSegmentIndex == 0  {
            return arrayOfCellData.count
        } else if segmentedControl.selectedSegmentIndex == 0  {
            return 0
        } else {
            return 0
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segmentedControl.selectedSegmentIndex == 0  {
        if arrayOfCellData[indexPath.row].cell == 1 {
            let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
            cell.mainImageView.image = arrayOfCellData[indexPath.row].image
            cell.mainLabelView.text = arrayOfCellData[indexPath.row].text
            cell.addressLabelView.text = arrayOfCellData[indexPath.row].address
            if let members = arrayOfCellData[indexPath.row].numOfCheckIns {
                cell.counterLabelView.text = String(describing: members)
            }
            cell.idLabel.text = arrayOfCellData[indexPath.row].id
            if let totalMembers = arrayOfCellData[indexPath.row].memberTotal {
                cell.totalMembers.text = String(describing: totalMembers)
            }
            return cell
        } else {
            let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
            cell.mainImageView.image = arrayOfCellData[indexPath.row].image
            cell.mainLabelView.text = arrayOfCellData[indexPath.row].text!
            cell.addressLabelView.text = arrayOfCellData[indexPath.row].address
            if let members = arrayOfCellData[indexPath.row].numOfCheckIns {
                cell.counterLabelView.text = String(describing: members)
            }
            cell.idLabel.text = arrayOfCellData[indexPath.row].id
            if let totalMembers = arrayOfCellData[indexPath.row].memberTotal {
                cell.totalMembers.text = String(describing: totalMembers)
            }
            return cell
            }
        } else if segmentedControl.selectedSegmentIndex == 1  {
            let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
            cell.mainImageView.image = arrayOfCellData[indexPath.row].image
            cell.mainLabelView.text = arrayOfCellData[indexPath.row].text!
            cell.addressLabelView.text = arrayOfCellData[indexPath.row].address
            if let members = arrayOfCellData[indexPath.row].numOfCheckIns {
                cell.counterLabelView.text = String(describing: members)
            }
            cell.idLabel.text = arrayOfCellData[indexPath.row].id
            if let totalMembers = arrayOfCellData[indexPath.row].memberTotal {
                cell.totalMembers.text = String(describing: totalMembers)
            }
            return cell
        } else {
            let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
            cell.mainImageView.image = arrayOfCellData[indexPath.row].image
            cell.mainLabelView.text = arrayOfCellData[indexPath.row].text!
            cell.addressLabelView.text = arrayOfCellData[indexPath.row].address
            if let members = arrayOfCellData[indexPath.row].numOfCheckIns {
                cell.counterLabelView.text = String(describing: members)
            }
            cell.idLabel.text = arrayOfCellData[indexPath.row].id
            if let totalMembers = arrayOfCellData[indexPath.row].memberTotal {
                cell.totalMembers.text = String(describing: totalMembers)
            }
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if segmentedControl.selectedSegmentIndex == 0  {
        if arrayOfCellData[indexPath.row].cell == 1 {
            return 235
        } else if arrayOfCellData[indexPath.row].cell == 2  {
            return 105
        } else {
            return 235
            }
        } else if segmentedControl.selectedSegmentIndex == 0 {
            return 235
        } else {
            return 235
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if segmentedControl.selectedSegmentIndex == 0  {
        performSegue(withIdentifier: "segue", sender: self)
        
        let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
        
        Constants.groupsName.myStrings = (cell.mainLabelView?.text!)!
        Constants.groupsLocation.myStrings = (cell.addressLabelView?.text!)!
        Constants.numberOfCheckIns.myInts = Int(cell.counterLabelView.text!)!
        Constants.idd.myStrings = (cell.idLabel?.text!)!
        Constants.numberOfMembers.myInts = Int((cell.totalMembers?.text!)!)!
        //        totalMembers
        }
    }


    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet var groupTableView: UITableView!
    @IBAction func infoButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "joinGroup", sender: self)
        
    }

    @IBAction func addGroups(_ sender: Any) {
        performSegue(withIdentifier: "addGroup", sender: self)
    }

    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        if segmentedControl.selectedSegmentIndex == 0  {
            let subViewOfSegment: UIView = segmentedControl.subviews[0] as UIView
            subViewOfSegment.tintColor = UIColor(red: 90/255, green: 200/255, blue: 250/255, alpha: 1)
        } else if segmentedControl.selectedSegmentIndex == 1  {
            let subViewOfSegment: UIView = segmentedControl.subviews[1] as UIView
            subViewOfSegment.tintColor = UIColor(red: 90/255, green: 200/255, blue: 250/255, alpha: 1)
        }
    }
}
//
//extension TableViewController: UITableViewDataSource {
//    
//}
