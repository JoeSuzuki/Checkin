//
//  ProfileViewController.swift
//  TimeTrack
//
//  Created by Joe Suzuki on 7/24/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit
import SCLAlertView
import Kingfisher
import FirebaseDatabase

class ProfileViewController: UIViewController {
    var profileHandle: DatabaseHandle = 0
    var profileRef: DatabaseReference?
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()        
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
    
    deinit {
        profileRef?.removeObserver(withHandle: profileHandle)
    }

    @IBAction func settingButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "edit", sender: self)
    }
    func configureView(){
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImage.clipsToBounds = true
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
}

