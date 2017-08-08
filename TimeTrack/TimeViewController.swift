//
//  TimeViewController.swift
//  TimeTrack
//
//  Created by Joe Suzuki on 7/28/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit
import Firebase

class TimeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    @IBOutlet weak var textBox1: UITextField!
    @IBOutlet weak var textBox2: UITextField!
    @IBOutlet weak var dayPicker1: UIPickerView!
    @IBOutlet weak var dayPicker2: UIPickerView!
    @IBOutlet weak var displayDaysLabel: UILabel!
    @IBOutlet weak var displayDaysLabel2: UILabel!
    
    // hides keyboard
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    // hides keyboard when pressing return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textBox1.resignFirstResponder()
        textBox2.resignFirstResponder()
        return(true)
    }
    
    let days = ["Sunday", "Monday", "Tuesday", "Wenesday", "Thursday", "Friday", "Saturday"]
    
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
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField == self.textBox1){
            self.dayPicker1.isHidden = false
        }
        else if (textField == self.textBox2){
            self.dayPicker2.isHidden = false
        }
    }
    
    var ref: DatabaseReference!
    let userID = Auth.auth().currentUser!.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ref = Database.database().reference().child("users").child(userID).child("groups").child("personal groups").childByAutoId()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func addButton(_ sender: UIButton){
        Constants.from.myStrings = textBox1.text as Any as! String
        Constants.to.myStrings = textBox2.text as Any as! String
      //  self.ref?.child("days").updateChildValues(["from": textBox1.text as Any])
      //  self.ref?.child("days").updateChildValues(["to": textBox2.text as Any])
        displayDaysLabel.text = textBox1.text
        displayDaysLabel2.text = textBox2.text
    }
    @IBAction func textBoxAction1(_ sender: UITextField) {
            Constants.from.myStrings = textBox1.text as Any as! String
            displayDaysLabel.text = textBox1.text
    }
    @IBAction func textBoxAction2(_ sender: UITextField) {
        displayDaysLabel2.text = textBox2.text
        Constants.to.myStrings = textBox2.text as Any as! String

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    //self.ref?.child("users").child(userID).child("groups").child("personal groups").childByAutoId().updateChildValues(["address": searchTextField.text])
    //self.ref?.child("users").child(userID).child("groups").updateChildValues(["personal groups": "ppppp"])
    

}
