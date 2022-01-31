//
//  RootStackTabViewController.swift
//  CustomTabBar
//
//  Created by apple on 17/05/21.
//

import UIKit

class RootStackTabViewController: UIViewController {

    @IBOutlet weak var bottomStack: UIStackView!
    
    @IBOutlet weak var stackView: UIView!
    @IBOutlet weak var displayView: UIView!
    var currentIndex = 0
    
    lazy var tabs: [StackItemView] = {
        var items = [StackItemView]()
        for _ in 0..<5 {
            items.append(StackItemView.newInstance)
        }
        return items
    }()
    
    lazy var tabModels: [BottomStackItem] = {
        return [
            BottomStackItem(title: "Home", image: "home"),
            BottomStackItem(title: "Favorites", image: "heart"),
            BottomStackItem(title: "Search", image: "search"),
            BottomStackItem(title: "Profile", image: "user"),
            BottomStackItem(title: "Settings", image: "settings")
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabs()
        viewsCHanged()
    }

    func setupTabs() {
        for (index, model) in self.tabModels.enumerated() {
            let tabView = self.tabs[index]
            model.isSelected = index == 0
            tabView.item = model
            tabView.delegate = self
            self.bottomStack.addArrangedSubview(tabView)
        }
    }
    
    func viewsCHanged() {
        print("called")
        
        title = tabModels[currentIndex].title
        
        switch currentIndex {
        case 0:
            let vc = storyboard?.instantiateViewController(identifier: "FIrstVC") as! FIrstVC
            displayView.frame = vc.view.frame
            displayView.addSubview(vc.view)
            break
        case 1:
            let vc = storyboard?.instantiateViewController(identifier: "SecondVC") as! SecondVC
            displayView.frame = vc.view.frame
            displayView.addSubview(vc.view)
            break
        case 2:
            let vc = storyboard?.instantiateViewController(identifier: "ThirdVC") as! ThirdVC
            displayView.frame = vc.view.frame
            displayView.addSubview(vc.view)
            break
        case 3:
            let vc = storyboard?.instantiateViewController(identifier: "FourVC") as! FourVC
            displayView.frame = vc.view.frame
            displayView.addSubview(vc.view)
            break
        case 4:
            let vc = storyboard?.instantiateViewController(identifier: "FiveVC") as! FiveVC
            displayView.frame = vc.view.frame
            displayView.addSubview(vc.view)
            break
        default:
            
            break
        }
        
        view.bringSubviewToFront(stackView)
        
    }
    
}

extension RootStackTabViewController: StackItemViewDelegate {
    
    func handleTap(_ view: StackItemView) {
        self.tabs[self.currentIndex].isSelected = false
        view.isSelected = true
        self.currentIndex = self.tabs.firstIndex(where: { $0 === view }) ?? 0
        
        print(self.currentIndex)
        viewsCHanged()
    }
    
}
