//
//  Joined.swift
//  TimeTrack
//
//  Created by Joe Suzuki on 8/14/17.
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
  
    var dictValue: [String : Any] {
        return ["groupUID" : groupUID,
                "ownerUID" : ownerUID,]
    }
    
    //Standard User init()
    init(groupUID: String, ownerUID: String) {
        self.groupUID = groupUID
        self.ownerUID = ownerUID
        super.init()
    }
    
    //User init using Firebase snapshots
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let groupUID = dict["groupUID"] as? String,
            let ownerUID = dict["ownerUID"] as? String
            else { return nil }
        self.groupUID = groupUID
        self.ownerUID = ownerUID
    }
}
