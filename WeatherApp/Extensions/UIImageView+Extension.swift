//
//  UIImageView+Extension.swift
//  WeatherApp
//
//  Created by Евгений Беляков on 24.03.2024.
//

import UIKit

extension UIImageView {
    static func createImageViewSystemIcon(for iconName: String, ofSize: CGFloat, renderingMode: UIImage.RenderingMode, tintColor: UIColor) -> UIImageView{
        let imgView = UIImageView()
        let weatherIconConfig = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: ofSize))
        imgView.image = UIImage(systemName: iconName, withConfiguration: weatherIconConfig)?.withRenderingMode(renderingMode)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        imgView.tintColor = tintColor
        
        return imgView
    }
}
