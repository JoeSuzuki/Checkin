//
//  Storyboard+Utility.swift
//  TimeTrack
//
//  Created by Joe Suzuki on 7/24/17.
//  Copyright © 2017 JoeSuzuki. All rights reserved.
//

import UIKit

extension UIStoryboard {
    enum TTType: String {
        case main
        case login
        
        var filename: String {
            return rawValue.capitalized
        }
    }
    convenience init(type: TTType, bundle: Bundle? = nil) {
        self.init(name: type.filename, bundle: bundle)
    }
    static func initialViewController(for type: TTType) -> UIViewController {
        let storyboard = UIStoryboard(type: type)
        guard let initialViewController = storyboard.instantiateInitialViewController() else {
            fatalError("Couldn't instantiate initial view controller for \(type.filename) storyboard.")
        }
        
        return initialViewController
    }
}
