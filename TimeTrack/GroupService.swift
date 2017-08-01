//
//  GroupService.swift
//  TimeTrack
//
//  Created by Joe Suzuki on 8/1/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import Foundation
import Firebase

struct GroupService {
    var ref: DatabaseReference?
    let userID = Auth.auth().currentUser!.uid

    static func grouper(forUID userID: String) {
        var ref: DatabaseReference?
        var names = [Any]()
        ref = Database.database().reference().child("groups").child(userID)
        ref?.observe(.childAdded, with: { (snapshot) -> Void in
            if let result = snapshot.value as? [String : Any] {
                let groupName = result["name"]
                names.append(groupName)
                print("Name: \(names)")
            }
        })
    }
}
