//
//  CurrentWeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by Евгений Беляков on 24.03.2024.
//

import UIKit

class CurrentWeatherCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "CurrentWeatherCollectionViewCell"
    
//    MARK: Cell view elements
    private let temperatureLabel: UILabel = UILabel.createLabel(fontSize: 60, fontWeight: .bold, textColor: .black, textAlignment: .center)
    
    private let weatherIcon: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        
        return imgView
    }()
    
    private lazy var temperatureIconStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [temperatureLabel, weatherIcon])
        stack.axis = .horizontal
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private let summaryLabel: UILabel = UILabel.createLabel(fontSize: 18, fontWeight: .regular, textColor: .black, textAlignment: .center)
    
    private let feelsLikeLabel: UILabel = UILabel.createLabel(fontSize: 18, fontWeight: .regular, textColor: .black, textAlignment: .center)
    
    private lazy var weatherDescriptionStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [windStackView, pressureStackView, humidityStackView])
        stack.axis = .horizontal
        stack.spacing = 15
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private let humidityLabel: UILabel = UILabel.createLabel(fontSize: 16, fontWeight: .regular, textColor: .black, textAlignment: .center)
    private let humidityIcon: UIImageView = UIImageView.createImageViewSystemIcon(for: "drop", ofSize: 20, renderingMode: .automatic, tintColor: .gray)
    
    private lazy var humidityStackView: UIStackView =  {
        let stack = UIStackView(arrangedSubviews: [humidityIcon, humidityLabel])
        stack.axis = .vertical
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private let windSpeedLabel: UILabel = UILabel.createLabel(fontSize: 16, fontWeight: .regular, textColor: .black, textAlignment: .center)
    private let windIcon: UIImageView = UIImageView.createImageViewSystemIcon(for: "wind", ofSize: 20, renderingMode: .automatic, tintColor: .gray)
    
    private lazy var windStackView: UIStackView =  {
        let stack = UIStackView(arrangedSubviews: [windIcon, windSpeedLabel])
        stack.axis = .vertical
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private let pressureLabel: UILabel = UILabel.createLabel(fontSize: 16, fontWeight: .regular, textColor: .black, textAlignment: .center)
    private let pressureIcon: UIImageView = UIImageView.createImageViewSystemIcon(for: "barometer", ofSize: 20, renderingMode: .automatic, tintColor: .gray)
    
    private lazy var pressureStackView: UIStackView =  {
        let stack = UIStackView(arrangedSubviews: [pressureIcon, pressureLabel])
        stack.axis = .vertical
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    //    MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Cell constraints
    func configureConstraints() {
        [temperatureIconStack, summaryLabel, feelsLikeLabel, weatherDescriptionStack].forEach{
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            temperatureIconStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            temperatureIconStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            summaryLabel.topAnchor.constraint(equalTo: temperatureIconStack.bottomAnchor, constant: 15),
            summaryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            summaryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            feelsLikeLabel.topAnchor.constraint(equalTo: summaryLabel.bottomAnchor),
            feelsLikeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            feelsLikeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            weatherDescriptionStack.topAnchor.constraint(equalTo: feelsLikeLabel.bottomAnchor, constant: 50),
            weatherDescriptionStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        weatherIcon.image = nil
        temperatureLabel.text = nil
        summaryLabel.text = nil
        feelsLikeLabel.text = nil
        windSpeedLabel.text = nil
        pressureLabel.text = nil
        humidityLabel.text = nil
    }
    
    //MARK: Cell configure
    func configure(with data: CurrentForecast) {
        let weatherIconConfig = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 60))
        weatherIcon.image = UIImage(systemName: IconApiDictionary[data.icon]!.rawValue, withConfiguration: weatherIconConfig)?.withRenderingMode(.alwaysOriginal)
        temperatureLabel.text = "\(data.temperature.toIntUp())°"
        summaryLabel.text = data.summary
        feelsLikeLabel.text =  "Fells like \(data.apparentTemperature.toIntUp())°"
        
        windSpeedLabel.text = "\((data.windSpeed / 3.6).toIntUp()) m/s, \(data.windBearing.toCompassDirection())"
        
        pressureLabel.text = "\((data.pressure / 1.333).toIntUp()) mmHg"
        
        humidityLabel.text = "\((data.humidity * 100).toIntUp()) %"
    }
    
    
}
