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
//    static func showJoinedGroupInfo(forUID keyed: String, currentUser: FIRUser, completion: @escaping (Joined?) -> Void) {
//        let reff = Database.database().reference().child("personal groups info").child(currentUser).child(keyed)
//        let membersRef = Database.database().reference().child("Members of Groups").child(keyed) // Get user uid
//        
//        membersRef.observeSingleEvent(of: .value, with: { (snapshot) in
//            guard let group = Joined(snapshot: snapshot) else {
//                return completion(nil)
//            }
//
//            completion(user)
//        })
//    }
//    
//    membersRef.observe(DataEventType.value, with: { (snapshot) in
//    let postDict = snapshot.value as? [String : AnyObject] ?? [:]
//    self.ownerUID = postDict["Owner"] as! String
//    print(self.ownerUID)
//    })
//    print(self.ownerUID)
//    
//    self.personalRef =  Database.database().reference().child("personal groups info").child(self.ownerUID).child(keyed!)// get info from other user
//    self.personalRef?.observe(.childAdded, with: {
//    (snapshot) in
//    // Get user value
//    let value = snapshot.value as! [String: AnyObject]
//    let name = value["name"] as? String
//    let location = value["location"] as? String
//    let checkIns = value["numOfCheckIns"] as? Int
//    let keyed = value["key"] as! String!
//    let mem = value["numOfMembers"] as? Int
//    let description = value["description"] as! String!
//    let from = value["from"] as! String!
//    let to = value["to"] as! String!
//    let url = value["url"] as! String!
//    let img = value["img"] as! String!
//    reff.child("location").setValue(location)
//    reff.child("from").setValue(from)
//    reff.child("to").setValue(to)
//    reff.child("name").setValue(name)
//    reff.child("description").setValue(description)
//    reff.child("img").setValue(img)
//    reff.child("url").setValue(url)
//    reff.child("key").setValue(keyed)
//    reff.child("numOfMembers").setValue(mem)
//    reff.child("numOfCheckIns").setValue(checkIns)
//    reff.child("owner").setValue(self.ownerUID)
//    })
