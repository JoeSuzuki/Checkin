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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //configureDatabase()
        ref = Database.database().reference().child("basic info").child(userID!)
//        let storageRef = Storage.storage().reference()
//        ref?.observe(.childAdded, with: { (snapshot)  in
//            if let result = snapshot.value as? [String : Any],
//                let groupImg = result["img"] as? [String : Any],
//                let img = groupImg["img"] as? String
//            {
//                let imaged = storageRef.child("users").child(self.userID!).child("groups").child(img)
//                
        self.ref?.observe(.childAdded, with: { (snapshot)  in
            if let result = snapshot.value as? [String : Any],
            let groupName = result["name"] as? [String : Any],
                let name = groupName["name"] as? String
            {
//                let groupName = result["name"]
                
                //print(result)
//                print(groupName as Any)
//                self.name.append(name)
                //print(self.name[0])
                self.arrayOfCellData.append(cellData(cell : 1, text : name , image : #imageLiteral(resourceName: "docotrsoffice")))
            }
        })
//            }
//        })
    }


    func configureDatabase() {
        ref = Database.database().reference().child("groups").child(userID!)
        // Listen for new messages in the Firebase database
        ref?.observe(.childAdded, with: { (snapshot)  in
            if let result = snapshot.value as? [String : Any] {
                //print(result)
                let groupName = result["name"]
               // print(groupName!)
            //    self.name.append(groupName as! String)
                //print(self.name)
                //self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: self.name.count-1, inSection: 0)], withRowAnimation: .Automatic)
            }
        })
    }
    
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
            );
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
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        performSegue(withIdentifier: "segue", sender: self)
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //Constants.groupsName.myStrings
    }


   }
