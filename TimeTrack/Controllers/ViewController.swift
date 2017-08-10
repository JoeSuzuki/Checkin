//
//  ViewController.swift
//  TimeTrack
//
//  Created by Joe Suzuki on 7/23/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var picker1: UIPickerView!
    @IBOutlet weak var picker2: UIPickerView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var time2: UILabel!
    
    let startTime = ["1","2","3","4","5","6","7","8","9","10","11","12"]
    let endTime = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countrow : Int = startTime.count
        var countrows : Int = endTime.count
        if pickerView == picker1 {
            countrows = self.startTime.count
        } else {
            countrows = self.endTime.count
        }
        return countrows
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == picker1 {
            let titleRow = startTime[row]
            return titleRow
        }
        else if pickerView == picker2{
            let titleRow = endTime[row]
            return titleRow
        }
        return ""
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == picker1 {
            self.time.text = self.startTime[row]
        }
        else if pickerView == picker2 {
            self.time2.text = self.endTime[row]
        }
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

