//
//  LocationRestrictedViewController.swift
//  WeatherApp
//
//  Created by Евгений Беляков on 22.03.2024.
//

import UIKit

/// This View Controller shows if user restrict or denied to provide his location
class NoUserLocationViewController: UIViewController {

    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "If you want to see your city weather, location settings need to be turned on in phone settings"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(label)
        
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40)
        ])
    }

}
