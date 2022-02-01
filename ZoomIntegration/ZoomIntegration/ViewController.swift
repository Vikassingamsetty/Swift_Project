//
//  ViewController.swift
//  ZoomIntegration
//
//  Created by Singamsetty Vikas on 25/01/22.
//

import UIKit
import MobileRTC

class ViewController: UIViewController {

    @IBOutlet weak var joinAMeetingBtn: UIButton!
    @IBOutlet weak var instanceMeetingBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. The Zoom SDK requires a UINavigationController to update the UI for us. Here we are supplying the SDK with the ViewControllers' navigationController.
        MobileRTC.shared().setMobileRTCRootController(self.navigationController)
        
    }

    
    @IBAction func JoinMeeting(_ sender: Any) {
        
        presentJoinMeetingAlert()
    }
    
    @IBAction func startInstanceMeeting(_ sender: Any) {
        
        startMeetingZak()
    }
    
    //Showing alert to take user inputs
    func presentJoinMeetingAlert() {
            let alertController = UIAlertController(title: "Join meeting", message: "", preferredStyle: .alert)

            alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Meeting number"
                textField.keyboardType = .phonePad
            }
            alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Meeting password"
                textField.keyboardType = .asciiCapable
                textField.isSecureTextEntry = true
            }

            let joinMeetingAction = UIAlertAction(title: "Join meeting", style: .default, handler: { alert -> Void in
                let numberTextField = alertController.textFields![0] as UITextField
                let passwordTextField = alertController.textFields![1] as UITextField

                if let meetingNumber = numberTextField.text, let password = passwordTextField.text {
                    self.joinMeeting(meetingNumber: meetingNumber, meetingPassword: password)
                }
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action : UIAlertAction!) -> Void in })

            alertController.addAction(joinMeetingAction)
            alertController.addAction(cancelAction)

            self.present(alertController, animated: true, completion: nil)
        }
    
    //Additional SDK functions
    func joinMeeting(meetingNumber: String, meetingPassword: String) {
        // Obtain the MobileRTCMeetingService from the Zoom SDK, this service can start meetings, join meetings, leave meetings, etc.
        if let meetingService = MobileRTC.shared().getMeetingService() {
            
            //delegate
            meetingService.delegate = self
            // Create a MobileRTCMeetingJoinParam to provide the MobileRTCMeetingService with the necessary info to join a meeting.
            // In this case, we will only need to provide a meeting number and password.
            let joinMeetingParameters = MobileRTCMeetingJoinParam()
            joinMeetingParameters.meetingNumber = meetingNumber
            joinMeetingParameters.password = meetingPassword
            
            meetingService.joinMeeting(with: joinMeetingParameters)
        }
    }
    
    
    //Instance meeting access
    func startMeetingZak() {
        if let meetingService = MobileRTC.shared().getMeetingService() {
            
            meetingService.delegate = self
            
            let startMeetingParams = MobileRTCMeetingStartParam4WithoutLoginUser()
            
            startMeetingParams.zak = "" // TODO: Enter ZAK
            startMeetingParams.userID = "" // TODO: Enter userID
            startMeetingParams.userName = "" // TODO: Enter your name
            
            meetingService.startMeeting(with: startMeetingParams)
        }
    }
    
}

extension ViewController: MobileRTCMeetingServiceDelegate {
    
    func onMeetingError(_ error: MobileRTCMeetError, message: String?) {
        
        switch error {
            
        case MobileRTCMeetError.passwordError:
            print("Could not join or start meeting because the meeting password was incorrect.")
        default:
            print("Could not join or start meeting with MobileRTCMeetError: \(error) \(message ?? "")")
        }
    }
    
    // Is called when the user joins a meeting.
    func onJoinMeetingConfirmed() {
        print("Join meeting confirmed.")
    }
    
    // Is called upon meeting state changes.
    func onMeetingStateChange(_ state: MobileRTCMeetingState) {
        print("Current meeting state: \(state)")
    }
    
}

