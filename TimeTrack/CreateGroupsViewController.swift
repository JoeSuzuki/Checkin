//
//  CreateGroupsViewController.swift
//  TimeTrack
//
//  Created by Joe Suzuki on 8/30/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import Foundation
import UIKit
import Eureka
import MapKit
import CoreLocation

class CreateGroupsViewController: FormViewController, CLLocationManagerDelegate {
    var locationManager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        form +++ Section("")
            <<< TextRow(){ row in
                row.title = "Name"
                row.placeholder = "Enter name here"
            }
            <<< TextAreaRow() {
                $0.placeholder = "Description"
                $0.textAreaHeight = .dynamic(initialTextViewHeight: 110)
            }
            +++ Section("Availblity")
            <<< LocationRow(){
                $0.title = "Location"
                $0.value = CLLocation(latitude: 40.71, longitude: 74.00)
            }
            <<< WeekDayRow(){
                $0.value = [.sunday, .monday, .tuesday, .wednesday, .thursday, .friday, .saturday]
            }

            <<< TimeInlineRow(){
                $0.title = "Open Time"
                $0.value = Date()
            }
            <<< TimeInlineRow(){
                $0.title = "Close Time"
                $0.value = Date()
            }
            <<< CountDownInlineRow(){
                $0.title = "Interval per Minute"
                var dateComp = DateComponents()
                dateComp.hour = 0
                dateComp.minute = 30
                dateComp.timeZone = TimeZone.current
                $0.value = Calendar.current.date(from: dateComp)
            }
            +++ Section("Contacts")
            <<< URLRow() {
                $0.title = "URL"
                $0.placeholder = ""
            }
            <<< PhoneRow(){
                $0.title = "Phone Number"
                $0.placeholder = "###-####-###"
            }
            <<< EmailRow() {
                $0.title = "Email Rule"
                $0.add(rule: RuleRequired())
                $0.add(rule: RuleEmail())
                $0.validationOptions = .validatesOnChangeAfterBlurred
            }
        

    	// Enables the navigation accessory and stops navigation when a disabled row is encountered
    navigationOptions = RowNavigationOptions.Enabled.union(.StopDisabledRow)
    // Enables smooth scrolling on navigation to off-screen rows
    animateScroll = true
    // Leaves 20pt of space between the keyboard and the highlighted row after scrolling to an off screen row
    rowKeyboardSpacing = 20
    }
  
}
