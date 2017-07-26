//
//  TableViewController.swift
//  TimeTrack
//
//  Created by Joe Suzuki on 7/26/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit

struct cellData {
    let cell: Int!
    let text: String?
    let image: UIImage?
}
class TableViewController: UITableViewController {

    var arrayOfCellData = [cellData]()
    
    override func viewDidLoad() {
        arrayOfCellData = [cellData(cell : 1, text : "Dr.Andy's office", image : #imageLiteral(resourceName: "docotrsoffice")),
                           cellData(cell : 1, text : "Dr. Bob's office", image : #imageLiteral(resourceName: "maxresdefault"))
//                           cellData(cell : 2, text : "llll", image : #imageLiteral(resourceName: "docotrsoffice")),
//                           cellData(cell : 1, text : "pppp", image : #imageLiteral(resourceName: "docotrsoffice"))
        ]
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
        } else if arrayOfCellData[indexPath.row].cell == 2  {
            let cell = Bundle.main.loadNibNamed("TableViewCell2", owner: self, options: nil)?.first as! TableViewCell2
            
            cell.mainImageView.image = arrayOfCellData[indexPath.row].image
            cell.mainLbl.text = arrayOfCellData[indexPath.row].text
            
            return cell
        } else {
            let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
            
            cell.mainImageView.image = arrayOfCellData[indexPath.row].image
            cell.mainLabelView.text = arrayOfCellData[indexPath.row].text
            
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
}
