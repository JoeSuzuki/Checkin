//
//  CreateTableViewController.swift
//  TimeTrack
//
//  Created by Joe Suzuki on 8/5/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit
import Firebase

class CreateTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference().child("users").child(userID).child("groups").child("personal groups").childByAutoId()
     self.clearsSelectionOnViewWillAppear = false
        self.timePicker1.datePickerMode = .time
        self.timePicker2.datePickerMode = .time
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    let days = ["Sunday", "Monday", "Tuesday", "Wenesday", "Thursday", "Friday", "Saturday"]
    var ref: DatabaseReference!
    let userID = Auth.auth().currentUser!.uid

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
        // hides keyboard
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
        // hides keyboard when pressing return
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textBox1.resignFirstResponder()
            textBox2.resignFirstResponder()
            groupNameTextField.resignFirstResponder()
            locationTextField.resignFirstResponder()
            urlText.resignFirstResponder()
            descriptionText.resignFirstResponder()
            return(true)
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
        func textFieldDidBeginEditing(_ textField: UITextField) {
            if (textField == self.textBox1){
                self.dayPicker1.isHidden = false
            }
            else if (textField == self.textBox2){
                self.dayPicker2.isHidden = false
            }
        }
        @IBAction func addButton(_ sender: UIButton) {
            Constants.location.myStrings = ["location": locationTextField.text as Any as! String]
            Constants.name.myStrings = ["name": groupNameTextField.text as
                Any as! String]
            Constants.from.myStrings = ["from": textBox1.text as Any as! String]
            Constants.to.myStrings = ["to": textBox2.text as Any as! String]
    }
    

    //
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 3
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell..

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
