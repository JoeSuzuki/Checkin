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
    static func show(forUID uid: String, completion: () -> Void) {
        let ref = Database.database().reference().child("users").child(uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let user = User(snapshot: snapshot) else {
                return completion(nil)
            }
            
            completion(user)
        })
    }
    
    func setUp() {
        ref?.observe(DataEventType.value, with: {
            (snapshot) in
            let value = snapshot.value as! [String: AnyObject]
            let timeInt = value["timeInt"] as? Int
            // let checkin = value["check-in"] as? Array
            self.timeInterval = timeInt!
            self.timeRef?.child("timeOpen").observe(DataEventType.value, with: {
                (snapshot) in
                let value = snapshot.value as! NSArray
                let hour = value[0] as? Int
                let min = value[1] as? Int
                let Apm = value[2] as? String
                self.startHour = hour!
                self.startMin = min!
                self.startAmpm = Apm!
                print(self.startHour)
                self.timeRef?.child("timeCloses").observe(DataEventType.value, with: {
                    (snapshot) in
                    let value = snapshot.value as! NSArray
                    let hours = value[0] as? Int
                    let mins = value[1] as? Int
                    let Apms = value[2] as? String
                    self.endHour = hours!
                    self.endMin = mins!
                    self.endAmpm = Apms!
                })
            })
        })
    }

}
