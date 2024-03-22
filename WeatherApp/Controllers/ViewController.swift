//
//  ViewController.swift
//  WeatherApp
//
//  Created by Евгений Беляков on 22.03.2024.
//

import UIKit

/// <#Description#>
class ViewController: UIViewController {
    
    //MARK: Variables
//    let locationManager: LocationManagerProtocol
    

    //MARK: Life Cycle Hooks
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        createNavBarTitle(for: "View")
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("appear")
    }

    //MARK: Methods
}

