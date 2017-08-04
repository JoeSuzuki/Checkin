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
        static var myStrings = [String: String]()
    }
    struct from {
        static var myStrings = [String: String]()
    }
    struct to {
        static var myStrings = [String: String]()
    }
    struct name {
        static var myStrings = [String: String]()
    }
    struct description {
        static var myStrings = [String: String]()
    }
    struct img {
        static var myImg =  [String: String]()
    }
// groups
    struct groupsName {
        static var myStrings: String = ""
    }
    struct groupsDescription {
        static var myStrings: String = ""
    }
    struct groupsLocation {
        static var myStrings: String = ""
    }
}
