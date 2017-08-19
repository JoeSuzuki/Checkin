//
//  UserService.swift
//
//  Created by Mariano Montori on 7/24/17.
//  Copyright © 2017 Mariano Montori. All rights reserved.
//

import UIKit
import Foundation
import FirebaseDatabase
import FirebaseStorage

struct UserService {
    static func create(_ firUser: FIRUser, username: String, firstName: String, lastName: String, image : UIImage?, completion: @escaping (User?) -> Void) {
        var userAttrs = ["username": username,
                         "firstName": firstName,
                         "lastName": lastName]
        let userRef = Database.database().reference().child("users").child(firUser.uid)
        if let image = image {
            let ref = Storage.storage().reference().child("images/profile/\(firUser.uid).jpg")
            StorageService.uploadImage(image, at: ref, completion: { (downloadURL) in
                guard let downloadURL = downloadURL else {
                    return
                }
                
                userAttrs["profileURL"] = downloadURL.absoluteString
                set(with: userAttrs, at: userRef, completion: { (user) in
                    completion(user)
                })
            })
        }
        else{
            set(with: userAttrs, at: userRef, completion: { (user) in
                completion(user)
            })
        }
    }
    
    static func edit(username: String, firstName: String, lastName: String, image : UIImage?, completion: @escaping (User?) -> Void) {
        var userAttrs = ["username": username,
                         "firstName": firstName,
                         "lastName": lastName]
        if let image = image {
            let ref = Storage.storage().reference().child("images/profile/\(User.current.uid).jpg")
            StorageService.uploadImage(image, at: ref, completion: { (downloadURL) in
                guard let downloadURL = downloadURL else {
                    return
                }
                
                userAttrs["profileURL"] = downloadURL.absoluteString
                update(with: userAttrs, completion: { (user) in
                    completion(user)
                })
            })
        }
        else {
            update(with: userAttrs, completion: { (user) in
                completion(user)
            })
        }
    }
    
    private static func set(with data : [String : Any], at ref : DatabaseReference, completion: @escaping (User?) -> Void) {
        ref.setValue(data) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                let user = User(snapshot: snapshot)
                completion(user)
            })
        }
    }
    
    private static func update(with data : [String : Any], completion: @escaping (User?) -> Void){
        let ref = Database.database().reference().child("users").child(User.current.uid)
        ref.updateChildValues(data) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                let user = User(snapshot: snapshot)
                completion(user)
            })
        }
        
    }
    
    static func show(forUID uid: String, completion: @escaping (User?) -> Void) {
        let ref = Database.database().reference().child("users").child(uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let user = User(snapshot: snapshot) else {
                return completion(nil)
            }
            
            completion(user)
        })
    }
    
    static func usersExcludingCurrentUser(completion: @escaping([User]) -> Void){
        let currentUser = User.current
        let ref = Database.database().reference().child("users")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {
                return completion([])
            }
            
            let users: [User] =
                snapshot
                    .flatMap(User.init)
                    .filter { $0.uid != currentUser.uid }
            
            completion(users)
        })
    }
    
    
    static func observeProfile(for user: User, completion: @escaping (DatabaseReference, User?) -> Void) -> DatabaseHandle {
        let userRef = Database.database().reference().child("users").child(user.uid)
        return userRef.observe(.value, with: { snapshot in
            guard let user = User(snapshot: snapshot) else {
                return completion(userRef, nil)
            }
            completion(userRef, user)
        })
    }
    
    static func deleteUser(for user: User, success: @escaping (Bool) -> Void) {
        let ref = Database.database().reference()
        let storageRef = Storage.storage().reference().child("images/profile/\(User.current.uid).jpg")
        var updatedData : [String : Any] = [:]
        var check = true
        
        let dispatcher = DispatchGroup()
        
        if let _ = user.profileURL {
            dispatcher.enter()
            StorageService.deleteImage(at: storageRef) { (result) in
                if !result {
                    check = false
                }
                dispatcher.leave()
            }
        }
        
        dispatcher.enter()
        ref.updateChildValues(updatedData) { (error, ref) -> Void in
            if let error = error {
                print("error : \(error.localizedDescription)")
                check = false
            }
            dispatcher.leave()
        }
        
        dispatcher.notify(queue: .main) {
            success(check)
        }
    }
    
}
