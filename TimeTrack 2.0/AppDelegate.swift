//
//  AppDelegate.swift
//  TimeTrack 2.0
//
//  Created by Joe Suzuki on 11/29/17.
//  Copyright © 2017 Joe Suzuki. All rights reserved.
//

import UIKit
import AWSMobileClient
import AWSCore


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions:
        
        [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        AWSDDLog.add(AWSDDTTYLogger.sharedInstance)
        AWSDDLog.sharedInstance.logLevel = .info
        return AWSMobileClient.sharedInstance().interceptApplication(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
}

