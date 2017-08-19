//
//  StorageService.swift
//  TimeTrack
//
//  Created by Joe Suzuki on 8/18/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit
import FirebaseStorage

struct StorageService {
    static func uploadImage(_ image: UIImage, at reference: StorageReference, completion: @escaping (URL?) -> Void) {
        
        guard let imageData = UIImageJPEGRepresentation(image, 0.1) else {
            return completion(nil)
        }
        
        reference.putData(imageData, metadata: nil, completion: { (metadata, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)!!")
                return completion(nil)
            }
            
            completion(metadata?.downloadURL())
        })
    }
    
    static func deleteImage(at ref : StorageReference, success: @escaping (Bool) -> Void){
        ref.delete { (error) in
            if let error = error {
                print("error : \(error.localizedDescription)")
                return success(false)
            }
            success(true)
        }
    }
}
