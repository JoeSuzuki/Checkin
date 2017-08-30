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
        var locationManager = CLLocationManager()
        form +++ Section("Section1")
            <<< TextRow(){ row in
                row.title = "Text Row"
                row.placeholder = "Enter text here"
            }
            <<< PhoneRow(){
                $0.title = "Phone Row"
                $0.placeholder = "And numbers here"
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
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation // note that locations is same as the one in the function declaration
    }
}
