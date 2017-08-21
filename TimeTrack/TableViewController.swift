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
struct joinedCellData {
    let cell: Int!
    let text: String?
    let image: UIImage?
    let address: String?
    let numOfCheckIns: Int?
    let id: String!
    let memberTotal: Int!
}
weak var photo: UIImage?
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
    var joinedArrayOfCellData = [joinedCellData](){
        didSet{
            groupTableView.reloadData()
        }
    }
    let storageRef = Storage.storage().reference()
    var ref: DatabaseReference?
    let userID = Auth.auth().currentUser?.uid
    var name: [String] = []
    var ownerRef: DatabaseReference?
    var memberRef: DatabaseReference?
    var personalRef: DatabaseReference?
    var ownerUID = ""
    var reff: DatabaseReference?
    //    var imageName: String = ""
    //    var imaged = UIImage?.self
    override func viewDidLoad() {
        super.viewDidLoad()
        groupTableView.separatorStyle = .none
        
        ref = Database.database().reference().child("personal groups info").child(userID!)
        ref?.queryOrderedByKey().observe(.childAdded, with: {
            (snapshot) in
            let value = snapshot.value as! [String: AnyObject]
            let name = value["name"] as? String
            let location = value["location"] as? String
            let checkIns = value["numOfCheckIns"] as? Int
            let keyed = value["key"] as! String!
            let mem = value["numOfMembers"] as? Int
            let img = value["img"] as? String?
            guard let pic = value["pic"] as? String else {
                var pic = "https://static.pexels.com/photos/58808/pexels-photo-58808.jpeg"
                return
            }
            let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
            let imageURL = URL(string: pic as! String)
            let imageView = cell.mainImageView
            imageView?.kf.setImage(with: imageURL)
            self.arrayOfCellData.append(cellData(cell : 1, text : name , image : imageView?.image, address: location, numOfCheckIns: checkIns, id: keyed, memberTotal: mem))
            
        })
        
        // join table view
        ownerRef = Database.database().reference().child("users").child(userID!).child("joined")// find groups that the user joined
        ownerRef?.queryOrderedByKey().observe(.childAdded, with: {
            (snapshot) in
            let value = snapshot.value as! [String: AnyObject]
            let keyed = value["key"] as! String! // set the group keys
            let reff = Database.database().reference().child("personal groups info").child(self.userID!).child(keyed!) // ref to personal groups for tableview
            self.memberRef = Database.database().reference().child("Members of Groups").child(keyed!) // find owner of the joined grou
            
            self.memberRef?.observe(.value, with: {
                (snapshot) in
                let value = snapshot.value as! [String: AnyObject]
                self.ownerUID = value["Owner"] as! String
                self.personalRef =  Database.database().reference().child("personal groups info").child(self.ownerUID).child(keyed!)
                self.personalRef?.observe(.value, with: { // get info from owner
                    (snapshot) in
                    let value = snapshot.value as! [String: AnyObject]
                    let name = value["name"] as? String
                    let location = value["location"] as? String
                    let checkIns = value["numOfCheckIns"] as? Int
                    let keyed = value["key"] as! String!
                    let mem = value["numOfMembers"] as? Int
                    let description = value["description"] as! String!
                    let from = value["from"] as! String!
                    let to = value["to"] as! String!
                    let img = value["img"] as! String!
                    guard let pics = value["pic"] as? String else {
                        var pics = "https://static.pexels.com/photos/58808/pexels-photo-58808.jpeg"
                        return
                    }
                    reff.child("pic").setValue(pics)
                    reff.child("location").setValue(location)
                    reff.child("from").setValue(from)
                    reff.child("to").setValue(to)
                    reff.child("name").setValue(name)
                    reff.child("description").setValue(description)
                    reff.child("img").setValue(img)
                    reff.child("key").setValue(keyed)
                    reff.child("numOfMembers").setValue(mem)
                    reff.child("numOfCheckIns").setValue(checkIns)
                    let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
                    let imageURL = URL(string: pics)
                    let imageView = cell.mainImageView
                    imageView?.kf.setImage(with: imageURL)
                    self.joinedArrayOfCellData.append(joinedCellData(cell : 1, text : name , image : imageView?.image, address: location, numOfCheckIns: checkIns, id: keyed, memberTotal: mem))
                })
            })
        })
        groupTableView?.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let index = self.groupTableView.indexPathForSelectedRow{
            self.groupTableView.deselectRow(at: index, animated: true)
        }
        let subViewOfSegment: UIView = segmentedControl.subviews[0] as UIView
        subViewOfSegment.tintColor = UIColor(red: 90/255, green: 200/255, blue: 250/255, alpha: 1)
        let subViewOfSegments: UIView = segmentedControl.subviews[1] as UIView
        subViewOfSegments.tintColor = UIColor(red: 90/255, green: 200/255, blue: 250/255, alpha: 1)
        groupTableView?.reloadData()

    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentedControl.selectedSegmentIndex == 0  {
            return arrayOfCellData.count
            groupTableView?.reloadData()
        } else if segmentedControl.selectedSegmentIndex == 1  {
            return joinedArrayOfCellData.count
            groupTableView?.reloadData()
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
                groupTableView?.reloadData()
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
                groupTableView?.reloadData()
            }
        } else if segmentedControl.selectedSegmentIndex == 1  { // seg2
            if joinedArrayOfCellData[indexPath.row].cell == 1 {
                let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
                cell.mainImageView.image = joinedArrayOfCellData[indexPath.row].image
                cell.mainLabelView.text = joinedArrayOfCellData[indexPath.row].text
                cell.addressLabelView.text = joinedArrayOfCellData[indexPath.row].address
                if let members = joinedArrayOfCellData[indexPath.row].numOfCheckIns {
                        cell.counterLabelView.text = String(describing: members)
                }
                cell.idLabel.text = joinedArrayOfCellData[indexPath.row].id
                if let totalMembers = joinedArrayOfCellData[indexPath.row].memberTotal {
                    cell.totalMembers.text = String(describing: totalMembers)
                }
                return cell
                    groupTableView?.reloadData()
            } else {
                let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
                cell.mainImageView.image = joinedArrayOfCellData[indexPath.row].image
                cell.mainLabelView.text = joinedArrayOfCellData[indexPath.row].text
                    cell.addressLabelView.text = joinedArrayOfCellData[indexPath.row].address
                if let members = joinedArrayOfCellData[indexPath.row].numOfCheckIns {
                cell.counterLabelView.text = String(describing: members)
                }
                cell.idLabel.text = joinedArrayOfCellData[indexPath.row].id
                if let totalMembers = joinedArrayOfCellData[indexPath.row].memberTotal {
                    cell.totalMembers.text = String(describing: totalMembers)
                }
                return cell
                groupTableView?.reloadData()
            }} else {
                let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
                return cell
                groupTableView?.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if segmentedControl.selectedSegmentIndex == 0  {
            if arrayOfCellData[indexPath.row].cell == 1 {
                return 235
            } else if arrayOfCellData[indexPath.row].cell == 2  {
                return 235
            } else {
                return 235
            }
        } else if segmentedControl.selectedSegmentIndex == 1 { // 2
            if joinedArrayOfCellData[indexPath.row].cell == 0 {
                return 235
            } else if joinedArrayOfCellData[indexPath.row].cell == 1 {
                return 235
            } else {
                return 235
            }
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
            photo = cell.mainImageView.image
            //        totalMembers
        } else if segmentedControl.selectedSegmentIndex == 1  {
            performSegue(withIdentifier: "segue", sender: self)
            
            let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
            
            Constants.groupsName.myStrings = (cell.mainLabelView?.text!)!
            Constants.groupsLocation.myStrings = (cell.addressLabelView?.text!)!
            Constants.numberOfCheckIns.myInts = Int(cell.counterLabelView.text!)!
            Constants.idd.myStrings = (cell.idLabel?.text!)!
            Constants.numberOfMembers.myInts = Int((cell.totalMembers?.text!)!)!
            photo = cell.mainImageView.image
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
        //        let rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("swiped:"))
        //        rightSwipe.direction = .right
        //        self.segmentedControl.addGestureRecognizer(rightSwipe)
        if segmentedControl.selectedSegmentIndex == 0  {
            let subViewOfSegment: UIView = segmentedControl.subviews[0] as UIView
            subViewOfSegment.tintColor = UIColor(red: 90/255, green: 200/255, blue: 250/255, alpha: 1)
            groupTableView?.reloadData()
        } else if segmentedControl.selectedSegmentIndex == 1  {
            let subViewOfSegment: UIView = segmentedControl.subviews[1] as UIView
            subViewOfSegment.tintColor = UIColor(red: 90/255, green: 200/255, blue: 250/255, alpha: 1)
            groupTableView?.reloadData()
        }
    }
}
//
//extension TableViewController: UITableViewDataSource {
//    
//}
