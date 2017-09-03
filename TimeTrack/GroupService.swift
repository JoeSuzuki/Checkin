//
//  GroupService.swift
//  TimeTrack
//
//  Created by Joe Suzuki on 8/1/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit
import Foundation
import Firebase

struct GroupService {
    static func create(for item : Joined, image : UIImage?, completion: @escaping (Joined?) -> Void) {
        let ref = Database.database().reference().child("personal groups info").child(User.current.uid).childByAutoId()
        if let image = image {
            let storageRef = Storage.storage().reference().child("images/groups/\(User.current.uid)/\(ref.key).jpg")
            StorageService.uploadImage(image, at: storageRef, completion: { (downloadURL) in
                guard let downloadURL = downloadURL else {
                    return
                }
                item.profileURL = downloadURL.absoluteString
                make(for: item, at: ref, completion: { (item) in
                    completion(item)
                })
            })
        }
        else {
            make(for: item, at: ref, completion: { (item) in
                completion(item)
            })
        }
    }
    private static func make(for item : Joined, at ref : DatabaseReference, completion: @escaping (Joined?) -> Void){
        ref.setValue(item.dictValue) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            show(for: User.current, with: ref.key, completion: { (item) in
                completion(item)
            })
        }
    }
    static func show(for user : User, with key : String, completion: @escaping (Joined?) -> Void){
        let ref = Database.database().reference().child("personal groups info").child(user.uid).child(key)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let item = Joined(snapshot: snapshot) else {
                return completion(nil)
            }
            completion(item)
        })
    }
    
}
