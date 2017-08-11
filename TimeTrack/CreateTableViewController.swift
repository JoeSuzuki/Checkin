//
//  CreateTableViewController.swift
//  TimeTrack
//
//  Created by Joe Suzuki on 8/5/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit
import Firebase
import SCLAlertView

let kSuccessTitled = "Awesome!"
let kErrorTitled = "Connection error"
let kNoticeTitled = "Notice"
let kWarningTitled = "Opps"
let kInfoTitled = "Info"
let kSubtitled = "The passcode you entered is incorrect"
let kSubtitldd = "You created a group! Go invite people to check-in!"

class CreateTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet weak var dayPicker1: UIPickerView!
    @IBOutlet weak var dayPicker2: UIPickerView!
    @IBOutlet weak var textBox1: UITextField!
    @IBOutlet weak var textBox2: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var urlText: UITextField!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var timeIntDisplay: UILabel!
    @IBOutlet weak var picker1: UIPickerView!
    @IBOutlet weak var picker2: UIPickerView!
    @IBOutlet weak var time2: UILabel!
    @IBOutlet weak var time1: UILabel!
    @IBOutlet weak var picker100: UIPickerView!
    @IBOutlet weak var picker200: UIPickerView!
    @IBOutlet weak var time10: UILabel!
    @IBOutlet weak var time20: UILabel!
    @IBOutlet weak var amLabel: UIPickerView!
    @IBOutlet weak var amLabel2: UIPickerView!
    @IBOutlet weak var am: UILabel!
    @IBOutlet weak var ampm: UILabel!
    
    
    let days = Constants.daysInWeek.days
    let startTime = Constants.hours.hour
    let endTime = Constants.minutes.min
    let amPm = ["AM", "PM"]
    var ref: DatabaseReference!
    let userID = Auth.auth().currentUser!.uid
    // image save
    var imagePicker = UIImagePickerController()
    let storageRef = Storage.storage().reference()
    let databaseRef = Database.database().reference()
    var refKey: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference().child("personal groups info").child(userID).childByAutoId()
        refKey = ref.key
        self.clearsSelectionOnViewWillAppear = false
        imagePicker.delegate = self
        var numOfMembers: Int = 0
        var numOfCheckIns: Int = 0
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard)))
        idLabel.text = refKey

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

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
            var countrowss : Int = endTime.count
            var countrow : Int = amPm.count
            if pickerView == dayPicker1 {
                countrows = self.days.count
                return countrows
            } else if pickerView == dayPicker2 {
                countrows = self.days.count
                return countrows
            } else if pickerView == picker1 {
                countrowss = self.startTime.count
                return countrowss
            } else if pickerView == picker100 {
                countrowss = self.startTime.count
                return countrowss
            } else if pickerView == picker200 {
                countrowss = self.endTime.count
                return countrowss
            } else if pickerView == amLabel {
                countrow = self.amPm.count
                return countrow
            } else if pickerView == amLabel2 {
                countrow = self.amPm.count
                return countrow
            }
            return countrowss
        }
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            if pickerView == dayPicker1 {
                let titleRow = days[row]
                return titleRow
            } else if pickerView == dayPicker2{
                let titleRow = days[row]
                return titleRow
            } else if pickerView == picker1 {
                let titleRow = startTime[row]
                return titleRow
            } else if pickerView == picker2{
                let titleRow = endTime[row]
                return titleRow
            } else if pickerView == picker100 {
                let titleRow = startTime[row]
                return titleRow
            } else if pickerView == picker200 {
                let titleRow = endTime[row]
                return titleRow
            } else if pickerView == amLabel {
                let titleRow = amPm[row]
                return titleRow
            } else if pickerView == amLabel2 {
                let titleRow = amPm[row]
                return titleRow
            }
            return ""
        }
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            if pickerView == dayPicker1 {
                self.textBox1.text = self.days[row]
            } else if pickerView == dayPicker2 {
                self.textBox2.text = self.days[row]
            } else if pickerView == picker1 {
                self.time1.text = self.startTime[row]
            } else if pickerView == picker2 {
                self.time2.text = self.endTime[row]
            } else if pickerView == picker100 {
                self.time10.text = self.startTime[row]
            } else if pickerView == picker200 {
                self.time20.text = self.endTime[row]
            } else if pickerView == amLabel {
                self.am.text = self.amPm[row]
            } else if pickerView == amLabel2 {
                self.ampm.text = self.amPm[row]
            }
        }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 15.0
    }
//    (Int(time1.text!)!, Int(time2.text!)!)
    func timeConvert(_ startTime: Int,_ endTime: Int,_ ms: String) -> Array<Any> {
        var newStartTime = startTime
        if ms == "PM" {
            newStartTime += 12
        }
        return [newStartTime, endTime, ms]
    }
    
    @IBAction func timePicker(_ sender: UIDatePicker) {
        let date = Date()
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        print("hours = \(hour):\(minutes):\(seconds)")
    }
    @IBAction func timeIntSilder(_ sender: UISlider) {
        timeIntDisplay.text = String(Int(sender.value))
        Constants.timeInterval.myInts = Int(sender.value)
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
        Constants.idd.myStrings = refKey
        Constants.timeOpens.time = timeConvert(Int(time1.text!)!, Int(time2.text!)!, am.text! )
        Constants.timeCloses.time = timeConvert(Int(time10.text!)!, Int(time20.text!)!, ampm.text! )
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
        self.ref.child("location").setValue(Constants.location.myStrings)
        self.ref.child("from").setValue(Constants.from.myStrings)
        self.ref.child("to").setValue(Constants.to.myStrings)
        self.ref.child("name").setValue(Constants.name.myStrings)
        self.ref.child("description").setValue(Constants.description.myStrings)
        self.ref.child("img").setValue(Constants.img.myImg)
        self.ref.child("url").setValue(Constants.url.myStrings)
        self.ref.child("key").setValue(Constants.idd.myStrings)
        self.ref.child("numOfMembers").setValue(Constants.numberOfMembers.myInts)
        self.ref.child("numOfCheckIns").setValue(Constants.numberOfCheckIns.myInts)
        let groupsRef = Database.database().reference().child("groupsIds")
        groupsRef.updateChildValues([Constants.idd.myStrings: Constants.idd.myStrings])
        let membersRef = Database.database().reference().child("Members of Groups").child(Constants.idd.myStrings)
        membersRef.updateChildValues([userID:userID])
        //performSegue(withIdentifier: "groupSegue", sender: self)
        let timeRef = Database.database().reference().child("time info").child(Constants.idd.myStrings)
        timeRef.child("timeInt").setValue(Constants.timeInterval.myInts)
        timeRef.child("timeOpen").setValue(Constants.timeOpens.time)
        timeRef.child("timeCloses").setValue(Constants.timeCloses.time)
        let initialViewController = UIStoryboard.initialViewController(for: .main)
        self.view.window?.rootViewController = initialViewController
        self.view.window?.makeKeyAndVisible()
        let alert = SCLAlertView()
        _ = alert.showSuccess(kSuccessTitled, subTitle: kSubtitldd)

    }
    @IBAction func cancelButton(_ sender: Any) {
        let initialViewController = UIStoryboard.initialViewController(for: .main)
        self.view.window?.rootViewController = initialViewController
        self.view.window?.makeKeyAndVisible()
    }
    }
