//
//  AppDelegate.swift
//  PlayerMedia
//
//  Created by Singamsetty Vikas on 22/10/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let screenRecordProtector = ScreenRecordingProtector()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        screenRecordProtector.startPreventing()
    }

}

