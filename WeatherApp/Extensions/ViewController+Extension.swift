//
//  ViewController+Extension.swift
//  WeatherApp
//
//  Created by Евгений Беляков on 23.03.2024.
//

import UIKit
import CoreLocation

fileprivate var containerView: UIView?

extension UIViewController{
    func createNavBarHamburgerButton(withAction action: UIAction?) {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        button.setImage(UIImage(named: "hamburger_icon")!.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        
        if let action = action {
            button.addAction(action, for: .touchUpInside)
        }
        
        let leftBarButtonItem = UIBarButtonItem(customView: button)
        leftBarButtonItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        leftBarButtonItem.customView?.heightAnchor.constraint(equalToConstant: 20).isActive = true
        leftBarButtonItem.customView?.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    private func createNavBarTitle(for title: String) {
        self.navigationItem.title = title
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
    
    func setCityNameToNavBarTitle(by location: CLLocation) {
        let geoCoder = CLGeocoder()
        Task{
            do{
                let placemarks = try await geoCoder.reverseGeocodeLocation(location)
                guard let placemark = placemarks.first else {return}
                createNavBarTitle(for: "\(placemark.locality ?? "view")")
            } catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func showLoadingView(){
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView!)
        
        containerView!.backgroundColor = UIColor(r: 173, g: 216, b: 230, a: 0.8)
        containerView!.alpha = 0
        
        UIView.animate(withDuration: 0.25){
            containerView!.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView!.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: containerView!.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: containerView!.centerYAnchor),
        ])
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        if(containerView == nil){return}
        containerView!.removeFromSuperview()
        containerView = nil
    }
}
