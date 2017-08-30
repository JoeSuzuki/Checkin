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
    let groupUID : String
    let ownerUID : String
    let name: String
    let address: String
    let startDay: String
    let endDay: String
    let startHour: Int
    let startMin: Int
    let startDM: String
    let endHour: Int
    let endMin: Int
    let endDM: String
    let interval: Int
    let descriptions: String
    let profileURL: String?
    var dictValue: [String : Any] {
        var data : [String : Any] = ["groupUID" : groupUID,
                                      "ownerUID" : ownerUID,
                                      "name" : name,
                                      "address" : address,
                                      "startDay" : startDay,
                                      "endDay" : endDay,
                                      "startTime" : startDay,
                                      "endDay" : endDay,
                                      "interval" : interval,
                                      "descriptions" : descriptions]
        if let url = profileURL {
            data["profileURL"] = url
        }
        return data
    }
    
    //Standard User init()
    init(groupUID: String, ownerUID: String, name: String, address: String, startDay: String, endDay: String, startHour: Int, startMin: Int, startDM: String, endHour: Int, endMin: Int, endDM: String, interval: Int, descriptions: String) {
        self.groupUID = groupUID
        self.ownerUID = ownerUID
        self.name = name
        self.address = address
        self.startDay = groupUID
        self.endDay = ownerUID
        self.startHour = startHour
        self.startMin = startMin
        self.startDM = startDM
        self.endHour = endHour
        self.endMin = endMin
        self.endDM = endDM
        self.interval = interval
        self.descriptions = descriptions
        self.profileURL = nil
        super.init()
    }
    
    //User init using Firebase snapshots
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let firstName = dict["firstName"] as? String,
            let lastName = dict["lastName"] as? String,
            let username = dict["username"] as? String
            else { return nil }
        if let url = dict["profileURL"] as? String {
            self.profileURL = url
        }
        else {
            self.profileURL = nil
        }
        self.uid = snapshot.key
        self.firstName = firstName
        self.lastName = lastName
        self.username = username
    }
    
    //UserDefaults
    required init?(coder aDecoder: NSCoder) {
        guard let uid = aDecoder.decodeObject(forKey: "uid") as? String,
            let firstName = aDecoder.decodeObject(forKey: "firstName") as? String,
            let lastName = aDecoder.decodeObject(forKey: "lastName") as? String,
            let username = aDecoder.decodeObject(forKey: "username") as? String,
            let url = aDecoder.decodeObject(forKey: "profileURL") as? String?
            else { return nil }
        
        self.uid = uid
        self.firstName = firstName
        self.lastName = lastName
        self.username = username
        self.profileURL = url
    }
}
