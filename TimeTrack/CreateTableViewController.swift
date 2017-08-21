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
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    
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
    var timeRef: DatabaseReference?
    var userPath: DatabaseReference?
    var timeInterval = 1
    var startHour: Int = 0
    var startMin: Int = 0
    var startAmpm: String = ""
    var endHour: Int = 0
    var endMin: Int = 0
    var endAmpm: String = ""
    var startTimes: String = ""
    var endTimes: String = ""
    var timeContainer = [String]()
    var hourContainer = [Int]()
    var minContainer = [Int]()
    var keysArray = [String]()
    var valuesArray = [String]()
    var organizeTime = [String]()
    var newItems = [DataSnapshot]()
    var fullName = ""
    var pictureCheck = false

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // addButton.isEnabled = false
        checkField()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference().child("personal groups info").child(userID).childByAutoId()
        refKey = ref.key
        timeRef = Database.database().reference().child("time info")
        self.clearsSelectionOnViewWillAppear = false
        imagePicker.delegate = self
        groupNameTextField.delegate = self
        locationTextField.delegate = self
        imageView = nil
        var numOfMembers: Int = 0
        var numOfCheckIns: Int = 0
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard)))
        idLabel.text = refKey
        checkField()
        PhotoHelper().completionHandler = { image in
            self.imageView.image = image
            self.pictureCheck = true
            self.imageView.kf.base.image = image
        }

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
        checkField()
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textBox1.resignFirstResponder()
        textBox2.resignFirstResponder()
        groupNameTextField.resignFirstResponder()
        locationTextField.resignFirstResponder()
        urlText.resignFirstResponder()
        descriptionText.resignFirstResponder()
        checkField()
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
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
            }
    @IBAction func editButtonClicked(_ sender: UIButton) {
        PhotoHelper().presentActionSheet(from: self)
    }
    func checkField() {
        if (groupNameTextField.text?.isEmpty)! && (locationTextField.text?.isEmpty)! && (time1.text?.isEmpty)! && (time2.text?.isEmpty)! && (am.text?.isEmpty)! && (time10.text?.isEmpty)! && (time20.text?.isEmpty)! && (ampm.text?.isEmpty)! {
            addButton.isEnabled = false
            }
        else{  
            addButton.isEnabled = true
        }
    }
    func timeSetup(){
        timeRef = Database.database().reference().child("time info").child(refKey)
        var nextStepHour = startHour
        var nextStepMin = startMin
        let timeIntHour = timeIntervalChange(timeInterval)[0]
        let timeIntMin = timeIntervalChange(timeInterval)[1]
        let minutesAdded = timeIntMin as! Int
        let hourAdded = timeIntHour as! Int
        
        while nextStepHour < endHour || nextStepMin < endMin {
            if nextStepHour +  hourAdded == endHour {
                if nextStepMin + minutesAdded < endMin {
                    nextStepHour +=  timeIntHour as! Int
                    nextStepMin += timeIntMin as! Int
                } else {
                    break
                }
            }
            if nextStepMin >= 60 {
                while nextStepMin >= 60 {
                    nextStepMin -= 60
                    nextStepHour += 1
                }
            }
            if nextStepHour + hourAdded < endHour || nextStepMin + minutesAdded < endMin {
                nextStepHour +=  timeIntHour as! Int
                nextStepMin += timeIntMin as! Int
                if nextStepMin >= 60 {
                    while nextStepMin >= 60 {
                        nextStepMin -= 60
                        nextStepHour += 1
                    }
                }
                timeDevolve(timeCreator(nextStepHour, nextStepMin))
            }
        }
    }
    func timeDevolve(_ stringTime: String) {// writes to firebase AM and PM times per interval
        timeRef = Database.database().reference().child("time info").child(refKey)
        let seperatedTimeList = stringTime.components(separatedBy: " ")
        let stringDm = seperatedTimeList[1]
        let beggining = seperatedTimeList[0]
        if stringDm == "AM" {
            timeRef?.child("AM").updateChildValues([stringTime: ""])
        } else if stringDm == "PM" {
            timeRef?.child("PM").updateChildValues([stringTime: ""])
        }
    }
    func timeCreator(_ hour: Int, _ min: Int) -> String { // takes ints and outputs a time friendly string
        var newHour = hour
        var Dm = ""
        var stringHour = ""
        var stringMin = ""
        if newHour > 12 {
            newHour -= 12
            Dm = "PM"
            if newHour < 10{
                stringHour = "0\(newHour)"
            } else {
                stringHour = "\(newHour)"
            }
            if min < 10 {
                stringMin = "\(min)0 "
            }else {
                stringMin = "\(min) "
            }
        } else {
            Dm = "AM"
            if newHour < 10{
                stringHour = "0\(newHour)"
            } else {
                stringHour = "\(newHour)"
            }
            if min < 10 {
                stringMin = "\(min)0 "
            }else {
                stringMin = "\(min) "
            }
        }
        return stringHour + ":" + stringMin + Dm
    }
    
    
    func timeIntervalChange(_ interval: Int) -> Array<Any>{
        var hour = 0
        var g = interval
        if interval > 60 {
            while g >= 60 {
                g -= 60
                hour += 1
            }
            return [hour , g]
        } else if interval == 60 {
            var newmin = 0
            var newHour = 1
            var newTime = [newHour, newmin]
            return newTime
        } else if interval < 60 {
            return [0,interval]
        } else {
            return [0,interval]
        }
    }
    func setUp(completion: @escaping (_ interval: Bool) -> Void){
        ref?.observe(DataEventType.value, with: {
            (snapshot) in
            let value = snapshot.value as! [String: AnyObject]
            let timeInt = value["timeInt"] as? Int
            // let checkin = value["check-in"] as? Array
            self.timeInterval = timeInt!
            completion(true)
        })
    }
    

    @IBAction func addButton(_ sender: Any) {
        var timeRef: DatabaseReference?
        Constants.location.myStrings = locationTextField.text!
        Constants.name.myStrings = groupNameTextField.text as
            Any as! String
        Constants.from.myStrings = textBox1.text as Any as! String
        Constants.to.myStrings = textBox2.text as Any as! String
        Constants.description.myStrings = descriptionText.text as Any as! String
        Constants.idd.myStrings = refKey
        timeRef = Database.database().reference().child("time info").child(Constants.idd.myStrings)
        Constants.timeOpens.time = timeConvert(Int(time1.text!)!, Int(time2.text!)!, am.text! )
        Constants.timeCloses.time = timeConvert(Int(time10.text!)!, Int(time20.text!)!, ampm.text! )
        let imageName = NSUUID().uuidString
        let storedImage = storageRef.child("users").child(userID).child("groups").child(imageName)
        Constants.img.myImg = imageName
        
        if let uploadData = UIImagePNGRepresentation((self.imageView?.image!)!){
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
        self.ref.child("owner").setValue(userID)
        self.ref.child("edit").setValue(true)
        let groupsRef = Database.database().reference().child("groupsIds")
        groupsRef.updateChildValues([Constants.idd.myStrings: Constants.idd.myStrings])
        let ownerRef = Database.database().reference().child("ownerIds")
        ownerRef.updateChildValues([userID: userID])
        let membersRef = Database.database().reference().child("Members of Groups").child(Constants.idd.myStrings)
        membersRef.updateChildValues(["Owner":userID])
        //performSegue(withIdentifier: "groupSegue", sender: self)
        timeRef?.child("timeInt").setValue(Constants.timeInterval.myInts)
        timeRef?.child("timeOpen").setValue(Constants.timeOpens.time)
        timeRef?.child("timeCloses").setValue(Constants.timeCloses.time)
        setUp() {_ in
            self.timeSetup()
        }
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
