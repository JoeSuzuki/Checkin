//
//  GroupTimeViewController.swift
//  TimeTrack
//
//  Created by Joe Suzuki on 8/3/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit

class GroupTimeViewController: UIViewController {

    @IBOutlet weak var mainImageViewSecon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       //mainTextViewSecon.text = Constants.groupsName.myStrings
       // mainImageViewSecon.layer.masksToBounds = false
        mainImageViewSecon.layer.cornerRadius = mainImageViewSecon.frame.size.width/2
        mainImageViewSecon.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
//     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//       
//    }
    
}



