//
//  MoreInfoGroupViewController.swift
//  TimeTrack
//
//  Created by Joe Suzuki on 8/4/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit

class MoreInfoGroupViewController: UIViewController {

    @IBOutlet weak var mainImageViewSecon: UIImageView!
    @IBOutlet weak var mainNameLabelSecon: UILabel!
    @IBOutlet weak var addressLabelSecon: UILabel!
    @IBOutlet weak var counterLabelSecon: UILabel!
    @IBOutlet weak var idLabelView: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        mainNameLabelSecon.text = Constants.groupsName.myStrings
        addressLabelSecon.text = Constants.groupsLocation.myStrings
        counterLabelSecon.text = String(Constants.numberOfCheckIns.myInts)
        idLabelView.text = Constants.idd.myStrings
        // mainImageViewSecon.layer.masksToBounds = false
        mainImageViewSecon.image = photo
        mainImageViewSecon.layer.cornerRadius = mainImageViewSecon.frame.size.width/2
        mainImageViewSecon.contentMode = UIViewContentMode.scaleAspectFill
        mainImageViewSecon.layer.masksToBounds = false
        mainImageViewSecon.clipsToBounds = true    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func checkInButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "time", sender: sender)
    }
    
     func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let groupTimeTableViewController = segue.destination as! GroupTimeTableViewController
        Constants.idd.myStrings = idLabelView.text!
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
