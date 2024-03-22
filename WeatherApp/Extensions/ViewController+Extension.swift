//
//  ViewController+Extension.swift
//  WeatherApp
//
//  Created by Евгений Беляков on 23.03.2024.
//

import UIKit

extension UIViewController{
    func createNavBarHamburgerButton(with action: UIAction?) {
        
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        button.setImage(UIImage(named: "hamburger_icon")!.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        button.addAction(UIAction{_ in print("im work")}, for: .touchUpInside)
        
        let leftBarButtonItem = UIBarButtonItem(customView: button)
        leftBarButtonItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        leftBarButtonItem.customView?.heightAnchor.constraint(equalToConstant: 20).isActive = true
        leftBarButtonItem.customView?.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    func createNavBarTitle(for title: String) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = .red
        
        self.navigationItem.titleView = titleLabel
    }
    
    func addChildVC(_ child: UIViewController, frame: CGRect?){
        addChild(child)
        if let frame = frame {
            child.view.frame = frame
        }
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func removeChildVC() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
