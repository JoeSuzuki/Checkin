////
////  Time.swift
////  TimeTrack
////
////  Created by Joe Suzuki on 8/15/17.
////  Copyright © 2017 JoeSuzuki. All rights reserved.
////
//
//import Foundation
//import UIKit
//import FirebaseDatabase.FIRDataSnapshot
//
//class Time : NSObject {
//    
//    //User variables
//    let timeInterval: Int
//    let startHour: Int
//    let startMin: Int
//    let startAmpm: String
//    let endHour: Int
//    let endMin: Int
//    let endAmpm: String
//    var dictValue: [String : Any] {
//        return ["timeInterval" : timeInterval, "startHour" : startHour,
//                "startMin" : startMin, "startAmpm" : startAmpm,
//                "endHour" : endHour, "endMin" : endMin,
//                "endAmpm" : endAmpm]
//    }
//    
//    //Standard User init()
//    init(timeInterval: Int, startHour: Int, startMin: Int, startAmpm: String, endHour: Int, endMin: Int, endAmpm: String) {
//        self.timeInterval = timeInterval
//        self.startHour = startHour
//        self.startMin = startMin
//        self.startAmpm = startAmpm
//        self.endHour = endHour
//        self.endMin = endMin
//        self.endAmpm = endAmpm
//    }
//    
//    //User init using Firebase snapshots
//    init?(snapshot: DataSnapshot) {
//        guard let dict = snapshot.value as? [String : Any],
//            let timeInterval = dict["timeInt"] as? Int,
//            let startHour = dict["timeOpen"][0] as? Int,
//            let startMin = dict.value("timeOpen")[1] as? Int,
//            let startAmpm = dict.child("timeOpen")[2] as? Int,
//            let endHour = dict.child("timeCloses")[0] as? Int,
//            let endMin = dict.child("timeCloses")[1] as? Int,
//            let endAmpm = dict.child("timeCloses")[2] as? Int
//            else { return nil }
//        self.timeInterval = timeInterval
//        self.startHour = startHour
//        self.startMin = startMin
//        self.startAmpm = startAmpm
//        self.endHour = endHour
//        self.endMin = endMin
//        self.endAmpm = endAmpm
//    }
//  }
