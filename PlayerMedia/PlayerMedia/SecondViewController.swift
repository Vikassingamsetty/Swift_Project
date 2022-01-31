//
//  SecondViewController.swift
//  PlayerMedia
//
//  Created by Singamsetty Vikas on 22/10/21.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onTapSend() {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "vc") as! ViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
    
}
