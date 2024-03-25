//
//  UIImageView+Extension.swift
//  WeatherApp
//
//  Created by Евгений Беляков on 24.03.2024.
//

import UIKit

extension UIImageView {    
    convenience init(iconName: String, ofSize: CGFloat, renderingMode: UIImage.RenderingMode, tintColor: UIColor){
        self.init(frame: .zero)
        let weatherIconConfig = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: ofSize))
        self.image = UIImage(systemName: iconName, ofSize: ofSize)?.withRenderingMode(renderingMode)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentMode = .scaleAspectFit
        self.tintColor = tintColor
    }
}
