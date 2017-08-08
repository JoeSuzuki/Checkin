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
        static var myInts: Int = 0
    }
    struct numberOfCheckIns {
        static var myInts: Int = 0
    }
    struct timeNow {
        static var time = [String: String]()
    }
    struct timeSet {
        static var time = [String: String]()
    }
    struct url {
        static var myStrings: String = ""
    }
    struct idd {
        static var myStrings: String = ""
    }
    
// Profile
    struct fullname {
        static var myStrings: String = ""
    }
}
