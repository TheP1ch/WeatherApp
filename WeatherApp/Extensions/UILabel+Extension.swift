//
//  UILabel+Extension.swift
//  WeatherApp
//
//  Created by Евгений Беляков on 24.03.2024.
//

import UIKit

extension UILabel{
    static func createLabel(fontSize: CGFloat, fontWeight: UIFont.Weight, textColor: UIColor, textAlignment: NSTextAlignment) -> UILabel{
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = textAlignment
        label.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        label.textColor = textColor
        
        return label
    }
}
