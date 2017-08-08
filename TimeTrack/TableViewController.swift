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
    @IBOutlet var groupTableView: UITableView!
    @IBAction func infoButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "joinGroup", sender: self)
    }
    @IBAction func addGroups(_ sender: Any) {
        performSegue(withIdentifier: "addGroup", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //configureDatabase()
        ref = Database.database().reference().child("basic info").child(userID!)
        ref?.queryOrderedByKey().observe(.childAdded, with: {
            (snapshot) in
            let value = snapshot.value as! [String: AnyObject]
            let name = value["name"] as? String
            let location = value["location"] as? String
            let checkIns: Int = value["numOfCheckIns"] as! Int
            self.arrayOfCellData.append(cellData(cell : 1, text : name , image : #imageLiteral(resourceName: "docotrsoffice"), address: location, numOfCheckIns: checkIns ))
        })
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
        return arrayOfCellData.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if arrayOfCellData[indexPath.row].cell == 1 {
            let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
            cell.mainImageView.image = arrayOfCellData[indexPath.row].image
            cell.mainLabelView.text = arrayOfCellData[indexPath.row].text
            cell.addressLabelView.text = arrayOfCellData[indexPath.row].address
            if let members = arrayOfCellData[indexPath.row].numOfCheckIns {
                cell.counterLabelView.text = String(describing: members)
            }
            return cell
        } else {
            let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
            cell.mainImageView.image = arrayOfCellData[indexPath.row].image
            cell.mainLabelView.text = arrayOfCellData[indexPath.row].text!
            cell.addressLabelView.text = arrayOfCellData[indexPath.row].address
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if arrayOfCellData[indexPath.row].cell == 1 {
            return 235
        } else if arrayOfCellData[indexPath.row].cell == 2  {
            return 105
        } else {
            return 235
        }
    }
   

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        performSegue(withIdentifier: "segue", sender: self)

        let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
        
        Constants.groupsName.myStrings = (cell.mainLabelView?.text!)!
        Constants.groupsLocation.myStrings = (cell.mainLabelView?.text!)!

    }

}
//
//extension TableViewController: UITableViewDataSource {
//    
//}
