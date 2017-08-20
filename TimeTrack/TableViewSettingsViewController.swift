//
//  TableViewSettingsViewController.swift
//  TimeTrack
//
//  Created by Joe Suzuki on 8/19/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//


import UIKit
import SCLAlertView
import Kingfisher
import FirebaseDatabase

class TableViewSettingsViewController: UITableViewController {
    var profileHandle: DatabaseHandle = 0
    var profileRef: DatabaseReference?

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureView()
        tableView?.reloadData()
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.separatorStyle = .none
        profileHandle = UserService.observeProfile(for: User.current) { [unowned self] (ref, user) in
            self.profileRef = ref
            guard let user = user else {
                return
            }
            User.setCurrent(user, writeToUserDefaults: true)
            self.setLabels()
            if let url = user.profileURL {
                self.resetProfilePic(url: url)
            }
        }
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    enum Section : Int {
        case accountSettings = 0
    }
    enum AccountSettings : Int {
        case profiles = 0
        case settings = 1
        case help = 2
        case logout = 3
    }
    func logout() {
        // create the alert
                    AuthService.presentLogOut(viewController: self)
        }        // create the alert

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section),
            let row = AccountSettings(rawValue: indexPath.row) else {
                return
        }

        switch section {
        case .accountSettings:
            switch row {
            case .profiles:
                performSegue(withIdentifier: "edit", sender: self)
            case .settings:
                print("hello")
            case .help:
                print("hello")
            case .logout:
                AuthService.presentLogOut(viewController: self)
            }
        }
    }

    func configureView(){
        profileImage.contentMode = UIViewContentMode.scaleAspectFill
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImage.clipsToBounds = true
//        profileImage.layer.masksToBounds = false
        setLabels()
    }
    func setLabels(){
        nameLabel.text = "\(User.current.firstName) \(User.current.lastName)"
        usernameLabel.text = User.current.username
    }
    func resetProfilePic(url : String){
        let imageURL = URL(string: url)
        self.profileImage.kf.setImage(with: imageURL)
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        if section == 0 {
            return 1
        } else if section == 1 {
            return 2
        } else {
            return 1
        }
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else if section == 1 {
            return 35
        } else {
            return 35
        }
    }

}
