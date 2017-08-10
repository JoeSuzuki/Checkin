//
//  GroupTime1TableViewController.swift
//  TimeTrack
//
//  Created by Joe Suzuki on 8/9/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

//import UIKit
//import Firebase
//
//struct timeData {
//    let cell: Int!
//    let name: String?
//    let time: String?
//}
//class GroupTime1TableViewController: UITableViewController {
//    var arrayOfCellData = [cellData](){
//        didSet{
//            groupTableView.reloadData()
//        }
//    }
//    var ref: DatabaseReference?
//    let userID = Auth.auth().currentUser?.uid
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//
//    // MARK: - Table view data source
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return arrayOfCellData.count
//    }
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if arrayOfCellData[indexPath.row].cell == 1 {
//            let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
//            cell.mainImageView.image = arrayOfCellData[indexPath.row].image
//            cell.mainLabelView.text = arrayOfCellData[indexPath.row].text
//            cell.addressLabelView.text = arrayOfCellData[indexPath.row].address
//            if let members = arrayOfCellData[indexPath.row].numOfCheckIns {
//                cell.counterLabelView.text = String(describing: members)
//            }
//            cell.idLabel.text = arrayOfCellData[indexPath.row].id
//            if let totalMembers = arrayOfCellData[indexPath.row].memberTotal {
//                cell.totalMembers.text = String(describing: totalMembers)
//            }
//            return cell
//        } else {
//            let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
//            cell.mainImageView.image = arrayOfCellData[indexPath.row].image
//            cell.mainLabelView.text = arrayOfCellData[indexPath.row].text!
//            cell.addressLabelView.text = arrayOfCellData[indexPath.row].address
//            if let members = arrayOfCellData[indexPath.row].numOfCheckIns {
//                cell.counterLabelView.text = String(describing: members)
//            }
//            cell.idLabel.text = arrayOfCellData[indexPath.row].id
//            if let totalMembers = arrayOfCellData[indexPath.row].memberTotal {
//                cell.totalMembers.text = String(describing: totalMembers)
//            }
//            return cell
//        }
//    }
//    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if arrayOfCellData[indexPath.row].cell == 1 {
//            return 235
//        } else if arrayOfCellData[indexPath.row].cell == 2  {
//            return 105
//        } else {
//            return 235
//        }
//    }
//    
//    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        performSegue(withIdentifier: "segue", sender: self)
//        
//        let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
//        
//        Constants.groupsName.myStrings = (cell.mainLabelView?.text!)!
//        Constants.groupsLocation.myStrings = (cell.addressLabelView?.text!)!
//        Constants.numberOfCheckIns.myInts = Int(cell.counterLabelView.text!)!
//        Constants.idd.myStrings = (cell.idLabel?.text!)!
//        Constants.numberOfMembers.myInts = Int((cell.totalMembers?.text!)!)!
//        //        totalMembers
//    }
//}
////
//
