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
}

class TableViewController: UITableViewController {

    //let ref = Database.database().reference().child("users")
    var tableText: String?
    var tableImage: UIImage?
    var arrayOfCellData = [cellData]()
    var ref: DatabaseReference?
    let userID = Auth.auth().currentUser?.uid
    var name: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //configureDatabase()
        ref = Database.database().reference().child("basic info").child(userID!)
        ref?.observe(.childAdded, with: { (snapshot)  in
            if let result = snapshot.value as? [String : AnyObject] {
                let groupName = result["name"]
                //print(result)
                //print(groupName)
                self.name.append(groupName! as! String)
                print(self.name[0])
            }
        })
        arrayOfCellData = [cellData(cell : 1, text : "Dr.Andy's office", image : #imageLiteral(resourceName: "docotrsoffice")),
                                  cellData(cell : 1, text : "Dr. Bob's office", image : #imageLiteral(resourceName: "maxresdefault")),
                    cellData(cell : 1, text : "Gods teeth office",
                             image : #imageLiteral(resourceName: "w")), cellData(cell : 1, text : name[0], image : #imageLiteral(resourceName: "docotrsoffice"))]
    }
    
    

//    func configureDatabase() {
//        ref = Database.database().reference().child("groups").child(userID!)
//        // Listen for new messages in the Firebase database
//        ref?.observe(.childAdded, with: { (snapshot)  in
//            if let result = snapshot.value as? [String : Any] {
//                //print(result)
//                let groupName = result["name"]
//               // print(groupName!)
//            //    self.name.append(groupName as! String)
//                //print(self.name)
//                //self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: self.name.count-1, inSection: 0)], withRowAnimation: .Automatic)
//            }
//        })
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfCellData.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if arrayOfCellData[indexPath.row].cell == 1 {
            let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
            
            cell.mainImageView.image = arrayOfCellData[indexPath.row].image
            cell.mainLabelView.text = arrayOfCellData[indexPath.row].text
    
            return cell
        } else {
            let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
            
            cell.mainImageView.image = arrayOfCellData[indexPath.row].image
            cell.mainLabelView.text = (arrayOfCellData[indexPath.row].text!
                
            );   return cell
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
}

//   c
