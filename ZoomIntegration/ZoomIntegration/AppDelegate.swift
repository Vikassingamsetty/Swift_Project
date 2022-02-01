//
//  AppDelegate.swift
//  ZoomIntegration
//
//  Created by Singamsetty Vikas on 25/01/22.
//

import UIKit
import MobileRTC


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    //1. Obtain your SDK Key and Secret and paste it here.
    let sdkKey = "le0rAOyAiqkfAv2jA4ZP6WdYZ9RuxwAWriXA"
    let sdkSecret = "gI5tzG1agFn6nmuCCH1EC6CAiVbO0YJ59GSN"
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //calling zoom sdk setup
        setupSDK(sdkKey: sdkKey, sdkSecret: sdkSecret)
        
        return true
    }
    
    
    // 2. Create a method that handles the initialization and authentication of the SDK
    func setupSDK(sdkKey: String, sdkSecret: String) {
        let context = MobileRTCSDKInitContext()
        context.domain = "zoom.us"
        context.enableLog = true
        
        let sdkInitializedSuccessfully = MobileRTC.shared().initialize(context)
        
        if sdkInitializedSuccessfully == true, let authorizationService = MobileRTC.shared().getAuthService() {
            
            authorizationService.clientKey = sdkKey
            authorizationService.clientSecret = sdkSecret
            
            //Set the delegate
            authorizationService.delegate = self
            authorizationService.sdkAuth()
        }
        
    }
    
    

}

extension AppDelegate: MobileRTCAuthDelegate {
    
    // Result of calling sdkAuth(). MobileRTCAuthError_Success represents a successful authorization.
    
    func onMobileRTCAuthReturn(_ returnValue: MobileRTCAuthError) {
        
        switch returnValue {
        case MobileRTCAuthError.success:
            print("SDK successfully initialized.")
            
        case MobileRTCAuthError.keyOrSecretEmpty:
            assertionFailure("SDK Key/Secret was not provided. Replace sdkKey and sdkSecret at the top of this file with your SDK Key/Secret.")
            
        case MobileRTCAuthError.unknown, MobileRTCAuthError.keyOrSecretWrong:
            assertionFailure("SDK Key/Secret is not valid.")
            
        default:
            assertionFailure("SDK Authorization failed with MobileRTCAuthError: \(returnValue).")
        }
        
    }
    
}
