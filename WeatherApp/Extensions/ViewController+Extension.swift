//
//  ViewController+Extension.swift
//  WeatherApp
//
//  Created by Евгений Беляков on 23.03.2024.
//

import UIKit
import CoreLocation

extension UIViewController{
    func createNavBarHamburgerButton(withAction action: UIAction?) {
        
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
    
    private func createNavBarTitle(for title: String) {
//        let titleLabel = UILabel()
//        titleLabel.text = title
//        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
//        titleLabel.tintColor = .red
        
        self.navigationItem.title = title
//        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.red, .font: UIFont.systemFont(ofSize: 16, weight: .bold)]
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
//                print("country\n")
//                print(placemark.country)
//
//                print("administrativeArea\n")
//                print(placemark.administrativeArea)
//
//                print("areasOfInterest")
//                print(placemark.areasOfInterest)
//
//                print("locality(city)")
//                print(placemark.locality)
//
//                print("region")
//                print(placemark.region)
//
//                print("subAdministrativeArea")
//                print(placemark.subAdministrativeArea)
                
                
            } catch{
                print(error.localizedDescription)
            }
        }
    }
}
