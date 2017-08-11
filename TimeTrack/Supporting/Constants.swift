//
//  Constants.swift
//  TimeTrack
//
//  Created by Joe Suzuki on 7/24/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import Foundation

struct Constants {
    struct Segue {
        static let toCreateUsername = "toCreateUsername"
    }
    struct UserDefaults {
        static let currentUser = "currentUser"
        static let uid = "uid"
        static let username = "username"
    }
    struct daysInWeek {
        static let days = ["Sunday", "Monday", "Tuesday", "Wenesday", "Thursday", "Friday", "Saturday"]
    }
    struct minutes {
        static let min = ["0", "1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59"]
    }
    struct hours {
        static let hour =  ["1","2","3","4","5","6","7","8","9","10","11","12"]
    }

    struct location {
        static var myStrings: String = ""
    }
    struct from {
        static var myStrings: String = ""
    }
    struct to {
        static var myStrings: String = ""
    }
    struct name {
        static var myStrings: String = ""
    }
    struct description {
        static var myStrings: String = ""
    }
    struct img {
        static var myImg: String = ""
    }
// groups
    struct groupDetails {
        static var myDicts = [String: Any]()
    }
    struct groupsName {
        static var myStrings: String = ""
    }
    struct groupsDescription {
        static var myStrings: String = ""
    }
    struct groupsLocation {
        static var myStrings: String = ""
    }
    struct numberOfMembers {
        static var myInts: Int = 1
    }
    struct numberOfCheckIns {
        static var myInts: Int = 0
    }
    struct timeNow {
        static var time = [String: String]()
    }
    struct timeOpens {
        static var time = [Any]()
    }
    struct timeCloses {
        static var time = [Any]()
    }
    struct url {
        static var myStrings: String = ""
    }
    struct idd {
        static var myStrings: String = ""
    }
    struct timeInterval {
        static var myInts: Int = 1
    }
    
// Profile
    struct fullname {
        static var myStrings: String = ""
    }
}
