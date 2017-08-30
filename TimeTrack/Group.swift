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
    let address: String//
    let startDay: String
    let endDay: String
    let startHour: Int//
    let startMin: Int
    let startDM: String
    let endHour: Int
    let endMin: Int
    let endDM: String
    let interval: Int
    let descriptions: String
    let profileURL: String?
    var dictValue: [String : Any] {
        var data : [String : Any] = ["ownerUID" : ownerUID,
                                      "name" : name,
                                      "address" : address,
                                      "startDay" : startDay,
                                      "endDay" : endDay,
                                      "startHour" : startHour,
                                      "startMin" : startMin,
                                      "startDM" : startDM,
                                      "endHour" : endHour,
                                      "endMin" : endMin,
                                      "endDM" : endDM,
                                      "interval" : interval,
                                      "descriptions" : descriptions]
        if let url = profileURL {
            data["profileURL"] = url
        }
        return data
    }
    
    //Standard User init()
    init(uid: String, ownerUID: String, name: String, address: String, startDay: String, endDay: String, startHour: Int, startMin: Int, startDM: String, endHour: Int, endMin: Int, endDM: String, interval: Int, descriptions: String) {
        self.uid = uid
        self.ownerUID = ownerUID
        self.name = name
        self.address = address
        self.startDay = startDay
        self.endDay = endDay
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
            let ownerUID = dict["ownerUID"] as? String,
            let name = dict["name"] as? String,
            let address = dict["address"] as? String,
            let startDay = dict["startDay"] as? String,
            let endDay = dict["endDay"] as? String,
            let startHour = dict["startHour"] as? Int,
            let startMin = dict["startMin"] as? Int,
            let startDM = dict["startDM"] as? String,
            let endHour = dict["endHour"] as? Int,
            let endMin = dict["endMin"] as? Int,
            let endDM = dict["endDM"] as? String,
            let interval = dict["interval"] as? Int,
            let descriptions = dict["descriptions"] as? String
            else { return nil }
        if let url = dict["profileURL"] as? String {
            self.profileURL = url
        }
        else {
            self.profileURL = nil
        }
        self.uid = snapshot.key
        self.ownerUID = ownerUID
        self.name = name
        self.address = address
        self.startDay = startDay
        self.endDay = endDay
        self.startHour = startHour
        self.startMin = startMin
        self.startDM = startDM
        self.endHour = endHour
        self.endMin = endMin
        self.endDM = endDM
        self.interval = interval
        self.descriptions = descriptions
    }
}
