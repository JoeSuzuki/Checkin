////
////  GroupService.swift
////  TimeTrack
////
////  Created by Joe Suzuki on 8/1/17.
////  Copyright © 2017 JoeSuzuki. All rights reserved.
////
//
//import Foundation
//import Firebase
//
//struct GroupService {
//    var ref: DatabaseReference?
//    let userID = Auth.auth().currentUser!.uid
//    var timeRef: DatabaseReference?
//
//    static func groupTimeInfo(_ uid: String, completion: @escaping (Time?) -> Void) {
//        let timeRef = Database.database().reference().child("time info").child(uid)
//
//        timeRef.observeSingleEvent(of: .value, with: { (snapshot) in
//            guard let time = Time(snapshot: snapshot) else {
//                return completion(nil)
//            }
//            completion(time)
//        })
//    }
//    
//}
