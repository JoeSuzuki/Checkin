//
//  GroupTimeViewController.swift
//  TimeTrack
//
//  Created by Joe Suzuki on 8/3/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit

class GroupTimeViewController: UIViewController {

    
    @IBOutlet weak var mainTextViewSecond: UILabel!
    @IBOutlet weak var mainImageViewSecond: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTextViewSecond.text = Constants.groupsName.myStrings
        mainImageViewSecond.layer.masksToBounds = false
        mainImageViewSecond.layer.cornerRadius = mainImageViewSecond.frame.size.width/2
        mainImageViewSecond.clipsToBounds = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
//     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//       return
//    }
    
}



