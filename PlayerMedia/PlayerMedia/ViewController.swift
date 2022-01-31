//
//  ViewController.swift
//  PlayerMedia
//
//  Created by Singamsetty Vikas on 22/10/21.
//

import AVFoundation
import AVKit
import UIKit

class ViewController: UIViewController {
    
    var recording = ScreenRecordingProtector()
    
    @IBOutlet weak var displayView: UIView!
    
    let playerViewController = AVPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recording.checkScreenRecord()
        let videoPath = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
        guard let url = URL(string: videoPath) else { return }
        let player = AVPlayer(url: url)
        player.rate = 1 //auto play
        
        playerViewController.player = player
        playerViewController.view.frame = displayView.bounds//playerFrame
        //playerViewController.showsPlaybackControls = false
        
        let button = UIButton(frame: CGRect(x: 50, y: 50, width: 100, height: 100))
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Vikas", for: .normal)
//        playerViewController.contentOverlayView?.addSubview(button)
        displayView.backgroundColor = .red
        
        NotificationCenter.default.addObserver(self, selector: #selector(pauseVideo(_:)), name: Notification.Name("VideoRecording"), object: nil)
    }
    
    @objc func pauseVideo(_ notification: NSNotification) {
        
        let value = notification.userInfo?["status"] as! Bool
        value == true ? playerViewController.player?.pause() : playerViewController.player?.play()
        
    }
    
    override func viewWillLayoutSubviews() {
        addChild(playerViewController)
        displayView.addSubview(playerViewController.view)
        playerViewController.didMove(toParent: self)
        recording.checkScreenRecord()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
    }
    
}
