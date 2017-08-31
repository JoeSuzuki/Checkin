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
    override func viewDidLoad() {
        super.viewDidLoad()
        form +++ Section("")
            <<< TextRow(){ row in
                row.title = "Name"
                row.placeholder = "Enter name here"
            }
            <<< TextRow(){ row in
                row.title = "Description"
                row.placeholder = "Enter description here"
            }
            <<< PhoneRow(){
                $0.title = "Phone Number"
                $0.placeholder = "###-####-###"
            }
            +++ Section("Section2")
            <<< DateRow(){
                $0.title = "Date Row"
                $0.value = Date(timeIntervalSinceReferenceDate: 0)
            }
            <<< LocationRow(){
                $0.title = "LocationRow"
                $0.value = CLLocation(latitude: -34.91, longitude: -56.1646)
            }
            
    	// Enables the navigation accessory and stops navigation when a disabled row is encountered
    navigationOptions = RowNavigationOptions.Enabled.union(.StopDisabledRow)
    // Enables smooth scrolling on navigation to off-screen rows
    animateScroll = true
    // Leaves 20pt of space between the keyboard and the highlighted row after scrolling to an off screen row
    rowKeyboardSpacing = 20
    }
  
}
