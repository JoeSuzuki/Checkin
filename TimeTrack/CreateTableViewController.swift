//
//  CreateTableViewController.swift
//  TimeTrack
//
//  Created by Joe Suzuki on 8/5/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit
import Firebase

class CreateTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet weak var dayPicker1: UIPickerView!
    @IBOutlet weak var dayPicker2: UIPickerView!
    @IBOutlet weak var textBox1: UITextField!
    @IBOutlet weak var textBox2: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var timePicker1: UIDatePicker!
    @IBOutlet weak var timePicker2: UIDatePicker!
    @IBOutlet weak var urlText: UITextField!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timeLabel2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference().child("users").child(userID).child("groups").child("personal groups").childByAutoId()
     self.clearsSelectionOnViewWillAppear = false
        self.timePicker1.datePickerMode = .time
        self.timePicker2.datePickerMode = .time
        imagePicker.delegate = self
        var numOfMembers: Int = 0
        var numOfCheckIns: Int = 0
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard)))
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    let days = ["Sunday", "Monday", "Tuesday", "Wenesday", "Thursday", "Friday", "Saturday"]
    var ref: DatabaseReference!
    let userID = Auth.auth().currentUser!.uid
    // image save
    var imagePicker = UIImagePickerController()
    let storageRef = Storage.storage().reference()
    let databaseRef = Database.database().reference()
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }
    
        // hides keyboard
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
        // hides keyboard when pressing return
    override func dismissKeyboard() {
        textBox1.resignFirstResponder()
        textBox2.resignFirstResponder()
        groupNameTextField.resignFirstResponder()
        locationTextField.resignFirstResponder()
        urlText.resignFirstResponder()
        descriptionText.resignFirstResponder()
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textBox1.resignFirstResponder()
        textBox2.resignFirstResponder()
        groupNameTextField.resignFirstResponder()
        locationTextField.resignFirstResponder()
        urlText.resignFirstResponder()
        descriptionText.resignFirstResponder()
        return true
    }
    
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            var countrows : Int = days.count
            if pickerView == dayPicker2 {
                countrows = self.days.count
            }
            return countrows
        }
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            if pickerView == dayPicker1 {
                let titleRow = days[row]
                return titleRow
            }
            else if pickerView == dayPicker2{
                let titleRow = days[row]
                return titleRow
            }
            return ""
        }
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            if pickerView == dayPicker1 {
                self.textBox1.text = self.days[row]
            }
            else if pickerView == dayPicker2 {
                self.textBox2.text = self.days[row]
            }
        }
    @IBAction func timePicker(_ sender: UIDatePicker) {
        let date = Date()
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        print("hours = \(hour):\(minutes):\(seconds)")
    }
    
    @IBAction func urlTextAction(_ sender: UITextField) {
        if urlText.text != nil {
            Constants.url.myStrings = urlText.text!
        } else {
            return
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
            if (textField == self.textBox1){
                self.dayPicker1.isHidden = false
            }
            else if (textField == self.textBox2){
                self.dayPicker2.isHidden = false
            }
        }
    @IBAction func editButtonClicked(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            selectedImageFromPicker = editedImage
        }else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            selectedImageFromPicker = originalImage
        }
        if let selectedImage = selectedImageFromPicker{
            imageView.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func addButton(_ sender: Any) {
        Constants.location.myStrings = locationTextField.text!
        Constants.name.myStrings = groupNameTextField.text as
            Any as! String
        Constants.from.myStrings = textBox1.text as Any as! String
        Constants.to.myStrings = textBox2.text as Any as! String
        Constants.description.myStrings = descriptionText.text as Any as! String
        
        ref = Database.database().reference().child("basic info").child(userID).childByAutoId()

        let imageName = NSUUID().uuidString
        let storedImage = storageRef.child("users").child(userID).child("groups").child(imageName)
        Constants.img.myImg = imageName
        
        if let uploadData = UIImagePNGRepresentation(self.imageView.image!){
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
                            self.ref!.updateChildValues(["pic" : urlText], withCompletionBlock: { (error, ref) in
                                if error != nil{
                                    print(error!)
                                    return
                                }
                            })
                        }
                    })
                })
            }
        // Write to Firebase
        var memref = Database.database().reference().child("groupsMembers").child(userID)
        var groupRef = Database.database().reference().child("basic info").child(userID)

        self.ref.child("location").setValue(Constants.location.myStrings)
        self.ref.child("from").setValue(Constants.from.myStrings)
        self.ref.child("to").setValue(Constants.to.myStrings)
        self.ref.child("name").setValue(Constants.name.myStrings)
        self.ref.child("description").setValue(Constants.description.myStrings)
        self.ref.child("img").setValue(Constants.img.myImg)
        self.ref.child("url").setValue(Constants.url.myStrings)
        self.ref.child("numOfMembers").setValue(Constants.numberOfMembers.myInts)
        self.ref.child("numOfCheckIns").setValue(Constants.numberOfCheckIns.myInts)
        //performSegue(withIdentifier: "groupSegue", sender: self)
        let initialViewController = UIStoryboard.initialViewController(for: .main)
        self.view.window?.rootViewController = initialViewController
        self.view.window?.makeKeyAndVisible()
    }
    @IBAction func cancelButton(_ sender: Any) {
        let initialViewController = UIStoryboard.initialViewController(for: .main)
        self.view.window?.rootViewController = initialViewController
        self.view.window?.makeKeyAndVisible()
    }
    }
