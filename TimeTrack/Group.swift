//
//  Group.swift
//  TimeTrack
//
//  Created by Joe Suzuki on 8/29/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase.FIRDataSnapshot

class Joined : NSObject {
    
    //User variables
    let uid : String
    let ownerUID : String
    let name: String
    let descriptions: String
    let address: String//
    let startDay: NSArray
    let startTime: String//
    let endTime: String
    let interval: TimeInterval
    let urls: String?
    let phoneNumber: String?
    let email: String?
    var profileURL: String?
    var dictValue: [String : Any] {
        var data : [String : Any] = ["ownerUID" : ownerUID,
                                      "name" : name,
                                      "address" : address,
                                      "startDay" : startDay,
                                      "startHour" : startTime,
                                      "endHour" : endTime,
                                      "interval" : interval,
                                      "descriptions" : descriptions]
        if let urls = urls {
            data["urls"] = urls
        }
        if let phoneNumber = phoneNumber {
            data["phoneNumber"] = phoneNumber
        }
        if let email = email {
            data["email"] = email
        }
        if let profileURL = profileURL {
            data["profileURL"] = profileURL
        }
        return data
    }
    
    //Standard User init()
    init(uid: String, ownerUID: String, name: String, address: String, startDay: NSArray, startHour: String, endHour: String, interval: TimeInterval, descriptions: String) {
        self.uid = uid
        self.ownerUID = ownerUID
        self.name = name
        self.address = address
        self.startDay = startDay
        self.startTime = startHour
        self.endTime = endHour
        self.interval = interval
        self.descriptions = descriptions
        self.urls = nil
        self.phoneNumber = nil
        self.email = nil
        self.profileURL = nil
        super.init()
    }
    
    //User init using Firebase snapshots
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let ownerUID = dict["ownerUID"] as? String,
            let name = dict["name"] as? String,
            let address = dict["address"] as? String,
            let startDay = dict["startDay"] as? NSArray,
            let startTime = dict["startTime"] as? String,
            let endTime = dict["endTime"] as? String,
            let interval = dict["interval"] as? TimeInterval,
            let descriptions = dict["descriptions"] as? String
            else { return nil }
        if let urls = dict["urls"] as? String {
            self.urls = urls
        }
        else {
            self.urls = nil
        }
        if let phoneNumber = dict["phoneNumber"] as? String {
            self.phoneNumber = phoneNumber
        }
        else {
            self.phoneNumber = nil
        }
        if let email = dict["email"] as? String {
            self.email = email
        }
        else {
            self.email = nil
        }
        if let profileURL = dict["profileURL"] as? String {
            self.profileURL = profileURL
        }
        else {
            self.profileURL = nil
        }
        self.uid = snapshot.key
        self.ownerUID = ownerUID
        self.name = name
        self.address = address
        self.startDay = startDay
        self.startTime = startTime
        self.endTime = endTime
        self.interval = interval
        self.descriptions = descriptions
    }
}
