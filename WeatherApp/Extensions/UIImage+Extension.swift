//
//  UIImage+Extension.swift
//  WeatherApp
//
//  Created by Евгений Беляков on 25.03.2024.
//

import UIKit

extension UIImage{
    convenience init?(systemName: String, ofSize: CGFloat) {
        let weatherIconConfig = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: ofSize))
        self.init(systemName: systemName, withConfiguration: weatherIconConfig)
    }
}
