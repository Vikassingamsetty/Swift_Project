//
//  Recording.swift
//  ScreenRecordingDetect
//
//  Created by Singamsetty Vikas on 07/10/21.
//

import UIKit

final class ScreenRecordingProtector {
    
    private var window: UIWindow? {
        return (UIApplication.shared.delegate as? AppDelegate)?.window
    }
    
    func startPreventing() {
        NotificationCenter.default.addObserver(self, selector: #selector(preventScreenShot), name: UIScreen.capturedDidChangeNotification, object: nil)
    }
    
    @objc func preventScreenShot() {
        
        DispatchQueue.main.async {
            self.checkScreenRecord()
        }
    }
    
    func checkScreenRecord() {
        var value = [String:Bool]()
        
        for screen in UIScreen.screens {
            
            if screen.isCaptured {
                print("recording")
                self.window?.isHidden = true
                value["status"] = true
                
            }else{
                print("Not recording")
                self.window?.isHidden = false
                value["status"] = false
                
            }
            
            NotificationCenter.default.post(name: Notification.Name("VideoRecording"), object: self, userInfo: value)
        }
    }
        
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
