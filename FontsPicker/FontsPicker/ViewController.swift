//
//  ViewController.swift
//  FontsPicker
//
//  Created by apple on 09/05/21.
//

import UIKit

class ViewController: UIViewController, UIFontPickerViewControllerDelegate {

    fileprivate let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 24)
        label.text = "RE future content:  Using multiple targets in an app. In particular, using a NotificationContentExtension to to modify a notification's secondary interface."
        return label
    }()
    
    private let button:UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Pick Font", for: .normal)
        button.addTarget(self, action: #selector(didTapPickFont), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(label)
        view.addSubview(button)
        label.font = UIFont(name: UserDefaults.standard.string(forKey: "FONTNAME") ?? "", size: 24)
        
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        label.frame = CGRect(x: 10, y: view.safeAreaInsets.top, width: view.frame.size.width - 20, height: view.frame.size.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom - 100)
        
        button.frame = CGRect(x: 20, y: view.frame.size.height - 100, width: view.frame.size.width - 40, height: 50)
    }

    @objc private func didTapPickFont() {
        
        let config = UIFontPickerViewController.Configuration()
        config.includeFaces = false
        let vc = UIFontPickerViewController(configuration: config)
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    func fontPickerViewControllerDidCancel(_ viewController: UIFontPickerViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func fontPickerViewControllerDidPickFont(_ viewController: UIFontPickerViewController) {
        viewController.dismiss(animated: true, completion: nil)
        guard let fontName = viewController.selectedFontDescriptor else {return}
        print(fontName.postscriptName)
        UserDefaults.standard.setValue(fontName.postscriptName, forKey: "FONTNAME")
        label.font = UIFont(name: fontName.postscriptName, size: 24)//UIFont(descriptor: fontName, size: 24)
    }
    
}
