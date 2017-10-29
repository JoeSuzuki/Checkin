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
import Kingfisher
import SCLAlertView
import PostalAddressRow

class CreateGroupsViewController: FormViewController, CLLocationManagerDelegate {
    var locationManager: CLLocationManager!
//    var newItem : Joined? = nil
    var name: String?
    var descriptions: String?
    var address: Array<Any>?
//    var startDay: NSArray = []
//    var startTime: String = ""
//    var endTime: String = ""
    var interval: TimeInterval = 0.0
    var urls: String?
    var phoneNumber: String?
    var email: String?
//    var profileURL: String? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        form +++ Section("General")
            <<< TextRow() {
                $0.title = "Name"
                $0.placeholder = "Enter name here"
                $0.onChange { [unowned self] row in
                    self.name = row.value
                    print(self.name)
                }
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
            }
                .cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
                }
                .onRowValidationChanged { cell, row in
                    let rowIndex = row.indexPath!.row
                    while row.section!.count > rowIndex + 1 && row.section?[rowIndex  + 1] is LabelRow {
                        row.section?.remove(at: rowIndex + 1)
                    }
                    if !row.isValid {
                        for (index, validationMsg) in row.validationErrors.map({ $0.msg }).enumerated() {
                            let labelRow = LabelRow() {
                                $0.title = validationMsg
                                $0.cell.height = { 30 }
                            }
                            row.section?.insert(labelRow, at: row.indexPath!.row + index + 1)
                        }
                    }
            }

            <<< TextAreaRow() {
                $0.placeholder = "Description"
                $0.textAreaHeight = .dynamic(initialTextViewHeight: 50)
                $0.onChange { [unowned self] row in
                    self.descriptions = row.value
                    print(self.descriptions)
                }
                
            }
            +++ Section("Availblity")
            <<< WeekDayRow(){
                $0.value = [.sunday, .monday, .tuesday, .wednesday, .thursday, .friday, .saturday]
//                $0.onChange { [unowned self] row in
//                    startDay = row.value
//                }
            }
            <<< TimeInlineRow(){
                $0.title = "Open Time"
                $0.value = Date()
                var time = TimeInlineRow().value
                print(time)
//                $0.onChange { [unowned self] row in
//                    startTime = row.value
//                }
            }
            <<< TimeInlineRow(){
                $0.title = "Close Time"
                $0.value = Date()
//                $0.onChange { [unowned self] row in
//                    endTime = row.value
//                }
            }
            <<< CountDownInlineRow(){
                $0.title = "Interval per Person"
                var dateComp = DateComponents()
                dateComp.hour = 0
                dateComp.minute = 30
                dateComp.timeZone = TimeZone.current
                $0.value = Calendar.current.date(from: dateComp)
//                $0.onChange { [unowned self] row in
//                    self.interval = row.value
//                }
            }
            +++ Section("Contacts")
            <<< PostalAddressRow() {
                $0.streetPlaceholder = "Street"
                $0.statePlaceholder = "State"
                $0.cityPlaceholder = "City"
                $0.countryPlaceholder = "Country"
                $0.postalCodePlaceholder = "Zip code"
//                $0.onChange { [unowned self] row in
//                    var location: String = "\(streetTextField), \(postalCodeTextField), \(cityTextField), \(stateTextField), \(countryTextField)"
//                }
            }
            <<< TextRow() {
                $0.title = "URL"
                $0.placeholder = "Enter URL here"
                $0.onChange { [unowned self] row in
                    self.urls = row.value
                }
            }
            <<< PhoneRow(){
                $0.title = "Phone Number"
                $0.placeholder = "###-####-###"
                $0.onChange { [unowned self] row in
                    self.phoneNumber = row.value
                    print(self.phoneNumber)
                }
            }
            <<< EmailRow() {
                $0.title = "Email"
                $0.add(rule: RuleEmail())
                $0.onChange { [unowned self] row in
                    self.email = row.value
                    print(self.email)
                }
            }
    	// Enables the navigation accessory and stops navigation when a disabled row is encountered
    navigationOptions = RowNavigationOptions.Enabled.union(.StopDisabledRow)
    // Enables smooth scrolling on navigation to off-screen rows
    animateScroll = true
    // Leaves 20pt of space between the keyboard and the highlighted row after scrolling to an off screen row
    rowKeyboardSpacing = 20
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: .saveButtonPressed)
        navigationItem.rightBarButtonItem = saveButton
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: .cancelButtonPressed)
        navigationItem.leftBarButtonItem = cancelButton
        UINavigationBar.appearance().tintColor = UIColor.white
        view.backgroundColor = .white
    }
    // MARK: - Actions
    func saveButtonPressed(_ sender: UIBarButtonItem) {
        print("ppp")
//        newItem = Joined(name: name, descriptions: descriptions, address: address, startDay: startDay, startTime: startTime, endTime: endTime, interval: interval, urls: urls, phoneNumber: phoneNumber, email: email, profileURL: profileURL)
//        
//        if let newItem = newItem  {
//            GroupService.create(for: newItem, image: image) { (item) in
//                self.newItem = item
//            }
//        }

    }
    func cancelButtonPressed(_ sender: UIBarButtonItem) {
    }
}
// MARK: - Selectors
extension Selector {
    fileprivate static let saveButtonPressed = #selector(CreateGroupsViewController.saveButtonPressed(_:))
    fileprivate static let cancelButtonPressed = #selector(CreateGroupsViewController.cancelButtonPressed(_:))
}

