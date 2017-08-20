//
//  EditViewController.swift
//  TimeTrack
//
//  Created by Joe Suzuki on 8/4/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit
import SCLAlertView
import Kingfisher
import FirebaseStorage

class EditViewController: UIViewController {
    
    let photoHelper = PhotoHelper()
    var pictureCheck = false
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var editImageButton: UIButton!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()

        photoHelper.completionHandler = { image in
            self.profileImageView.kf.base.image = image
            self.pictureCheck = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func saveClicked(_ sender: UIButton) {
        guard let username = usernameTextField.text,
            let firstName = firstNameTextField.text,
            let lastName = lastNameTextField.text
            else { return }
        
        if username == User.current.username &&
            firstName == User.current.firstName &&
            lastName == User.current.lastName &&
            !pictureCheck {
            SCLAlertView().showWarning("No changes made.", subTitle: "Make changes to your profile first.")
            return
        }
        
        var image : UIImage? = nil
        if pictureCheck {
            image = self.profileImageView.kf.base.image
        }
        
        UserService.edit(username: username, firstName: firstName, lastName: lastName, image: image) { (user) in
            
            User.setCurrent(user!, writeToUserDefaults: true)
            SCLAlertView().showSuccess("Success!", subTitle: "Your changes have been saved.")
        }
    }
    @IBAction func unwindToRootViewController(segue: UIStoryboardSegue) {
    }


    @IBAction func editImageClicked(_ sender: UIButton) {
        photoHelper.presentActionSheet(from: self)
    }
}

extension EditViewController {
    func configureView() {
        applyKeyboardDismisser()
        
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width/2
        profileImageView.clipsToBounds = true
        editImageButton.layer.cornerRadius = editImageButton.frame.size.width/2
        editImageButton.clipsToBounds = true
        
        if let url = User.current.profileURL {
            let imageURL = URL(string: url)
            profileImageView.kf.setImage(with: imageURL)
        }
        else {
            profileImageView.kf.base.image = UIImage(named: "defaultProfile")
        }
        
        firstNameTextField.text = User.current.firstName
        lastNameTextField.text = User.current.lastName
        usernameTextField.text = User.current.username
    }
}
