//
//  ProfileViewController.swift
//  TimeTrack
//
//  Created by Joe Suzuki on 7/24/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //variables
    let storageRef = Storage.storage().reference()
    let databaseRef = Database.database().reference()
    
    //outlets
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser?.uid == nil{
            logout()
        }
        setupProfile()
        
    }
    //actions
    @IBAction func imageEditButton(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    @IBAction func saveButton(_ sender: UIButton) {
        saveChanges()
    }
    @IBAction func logoutButton(_ sender: UIButton) {
        logout()
    }
    
    //func
    func setupProfile(){
        
        
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImage.clipsToBounds = true
        if let uid = Auth.auth().currentUser?.uid{
            databaseRef.child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                if let dict = snapshot.value as? [String: AnyObject]
                {
                    self.usernameLabel.text = dict["username"] as? String
                    if let profileImageURL = dict["pic"] as? String
                    {
                        let url = URL(string: profileImageURL)
                        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                            if error != nil{
                                print(error!)
                                return
                            }
                            DispatchQueue.main.async {
                                self.profileImage?.image = UIImage(data: data!)
                            }
                        }).resume()
                    }
                }
            })
            
        }
    }
    func logout(){
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        let storyProfile = UIStoryboard(name: "Login", bundle: nil)
        let loginViewController = storyProfile.instantiateViewController(withIdentifier: "login")
        present(loginViewController, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            selectedImageFromPicker = editedImage
        }else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            selectedImageFromPicker = originalImage
        }
        if let selectedImage = selectedImageFromPicker{
            profileImage.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func saveChanges(){
        
        let imageName = NSUUID().uuidString
        
        let storedImage = storageRef.child("profile_images").child(imageName)
        
        if let uploadData = UIImagePNGRepresentation(self.profileImage.image!)
        {
            storedImage.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                if error != nil{
                    print(error!)
                    return
                }
                storedImage.downloadURL(completion: { (url, error) in
                    if error != nil{
                        print(error!)
                        return
                    }
                    if let urlText = url?.absoluteString{
                        self.databaseRef.child("users").child((Auth.auth().currentUser?.uid)!).updateChildValues(["pic" : urlText], withCompletionBlock: { (error, ref) in
                            if error != nil{
                                print(error!)
                                return
                            }
                        })
                    }
                })
            })
        }
    }
}
