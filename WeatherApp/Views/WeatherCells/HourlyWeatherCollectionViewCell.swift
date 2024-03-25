//
//  HourlyWeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by Евгений Беляков on 24.03.2024.
//

import UIKit

class HourlyWeatherCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "HourlyWeatherCollectionViewCell"
    
    private let dateFormatter:DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:00"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        return dateFormatter
    }()
    
    //MARK: cell views
    private let timeLabel: UILabel = UILabel(fontSize: 16, fontWeight: .regular, textColor: .black, textAlignment: .center)
    
    private let temperatureLabel: UILabel = UILabel(fontSize: 16, fontWeight: .bold, textColor: .black, textAlignment: .center)
    
    private let weatherIcon: UIImageView = UIImageView(iconName: "", ofSize: 10, renderingMode: .alwaysOriginal, tintColor: .systemBackground)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor(r: 173, g: 216, b: 230, a: 0.8)
        contentView.layer.cornerRadius = 15
        
        contentView.layer.shadowColor = UIColor.gray.cgColor
        contentView.layer.shadowOpacity = 0.45
        contentView.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        contentView.layer.shadowRadius = 7
        contentView.layer.shadowPath = UIBezierPath(roundedRect: contentView.bounds, cornerRadius: 15).cgPath
        contentView.layer.shouldRasterize = true
        contentView.layer.rasterizationScale = UIScreen.main.scale
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Cell constraints
    private func configureConstraints() {
        [weatherIcon, timeLabel, temperatureLabel].forEach{
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            timeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            weatherIcon.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 10),
            weatherIcon.centerXAnchor.constraint(equalTo: timeLabel.centerXAnchor),
            
            temperatureLabel.topAnchor.constraint(equalTo: weatherIcon.bottomAnchor, constant: 10),
            temperatureLabel.centerXAnchor.constraint(equalTo: timeLabel.centerXAnchor),
//            temperatureLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    //MARK: Cell configure
    func configure(with data: HourlyWeather) {
        let date = Date(timeIntervalSince1970: TimeInterval(data.time))
        if(date.compareWithCurrent(onlyByDate: false)){
            timeLabel.text = "Now"
        } else {
            timeLabel.text = dateFormatter.string(from: date)
        }
        
        let weatherIconConfig = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 20))
        weatherIcon.image = UIImage(systemName: IconApiDictionary[data.icon]!.rawValue, withConfiguration: weatherIconConfig)?.withRenderingMode(.alwaysOriginal)
        
        temperatureLabel.text = "\(data.temperature > 0 ? "+" : "")\(data.temperature.toIntUp())°"
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        temperatureLabel.text = nil
        timeLabel.text = nil
        weatherIcon.image = nil
    }
    
}
