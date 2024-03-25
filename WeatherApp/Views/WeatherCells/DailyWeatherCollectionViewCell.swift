//
//  DailyWeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by Евгений Беляков on 24.03.2024.
//

import UIKit

class DailyWeatherCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "DailyWeatherCollectionViewCell"
    
    private let dateFormatter:DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_EN")

        return dateFormatter
    }()
    
    //MARK: cell views
    private let dateLabel: UILabel = UILabel(fontSize: 12, fontWeight: .light, textColor: .black, textAlignment: .center)
    
    private let dayLabel: UILabel = UILabel(fontSize: 16, fontWeight: .bold, textColor: .black, textAlignment: .center)
    
    private let weatherIcon: UIImageView = UIImageView(iconName: "", ofSize: 10, renderingMode: .alwaysOriginal, tintColor: .systemBackground)
    
    private let highTemperatureLabel: UILabel = UILabel(fontSize: 16, fontWeight: .bold, textColor: .black, textAlignment: .center)
    
    private let lowTemperatureLabel: UILabel = UILabel(fontSize: 16, fontWeight: .light, textColor: .black, textAlignment: .center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor(r: 173, g: 216, b: 230, a: 0.8)
        contentView.layer.cornerRadius = 10
        
        contentView.layer.shadowColor = UIColor.white.cgColor
        contentView.layer.shadowOpacity = 0.6
        contentView.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        contentView.layer.shadowRadius = 5
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
        [weatherIcon, dateLabel, dayLabel, highTemperatureLabel, lowTemperatureLabel].forEach{
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            dayLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 2.5),
            dayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
//            dayLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            lowTemperatureLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            lowTemperatureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            lowTemperatureLabel.widthAnchor.constraint(equalToConstant: 70),
            
            highTemperatureLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            highTemperatureLabel.trailingAnchor.constraint(equalTo: lowTemperatureLabel.leadingAnchor, constant: -10),
            highTemperatureLabel.widthAnchor.constraint(equalToConstant: 70),
            
            weatherIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            weatherIcon.trailingAnchor.constraint(equalTo: highTemperatureLabel.leadingAnchor, constant: -10),
            weatherIcon.widthAnchor.constraint(equalToConstant: 40),
            weatherIcon.widthAnchor.constraint(equalToConstant: 40),
            
        ])
    }
    
    func configure(with data: DailyForecast) {
        let date = Date(timeIntervalSince1970: TimeInterval(data.time))
        if(date.compareWithCurrent(onlyByDate: true)){
            dayLabel.text = "Today"
        } else {
            dateFormatter.dateFormat = "EEEE"
            dayLabel.text = dateFormatter.string(from: date)
        }
        
        dateFormatter.dateFormat = "MMMM d"
        dateLabel.text = dateFormatter.string(from: date)
        
        let weatherIconConfig = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 25))
        weatherIcon.image = UIImage(systemName: IconApiDictionary[data.icon]!.rawValue, withConfiguration: weatherIconConfig)?.withRenderingMode(.alwaysOriginal)
        
        highTemperatureLabel.text = "H: \(data.temperatureMax.toIntUp())°"
        lowTemperatureLabel.text = "L: \(data.temperatureMin.toIntUp())°"
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        highTemperatureLabel.text = nil
        lowTemperatureLabel.text = nil
        
        weatherIcon.image = nil
        dayLabel.text = nil
        dateLabel.text = nil
    }
}
