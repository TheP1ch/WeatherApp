//
//  CurrentWeatherView.swift
//  WeatherApp
//
//  Created by Евгений Беляков on 24.03.2024.
//

import UIKit

class CurrentWeatherView: UIView {
    
    private var weatherForecastData: [WeatherForecastDataSourceModel] = []
    
    weak var delegate: ReloadDataProtocol?
    
    //MARK: View UIElements
    
    
    private var collectionView: UICollectionView?
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl(frame: .zero, primaryAction: refreshAction)
        refreshControl.tintColor = .gray
        
        return refreshControl
    }()

    //MARK: -initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        createCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(weatherForecastData: [WeatherForecastDataSourceModel]){
        self.weatherForecastData = weatherForecastData
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
    //MARK: configure Collection View
    /// Method create collectionView and set constraints
    func createCollectionView() {
        let layout = UICollectionViewCompositionalLayout {sectionIndex, _ in
            self.layout(for: sectionIndex)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.register(CurrentWeatherCollectionViewCell.self, forCellWithReuseIdentifier: CurrentWeatherCollectionViewCell.cellIdentifier)
        collectionView.register(HourlyWeatherCollectionViewCell.self, forCellWithReuseIdentifier: HourlyWeatherCollectionViewCell.cellIdentifier)
        collectionView.register(DailyWeatherCollectionViewCell.self, forCellWithReuseIdentifier: DailyWeatherCollectionViewCell.cellIdentifier)
        
        collectionView.backgroundColor = UIColor(r: 173, g: 216, b: 230, a: 0.8)
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

        collectionView.refreshControl = refreshControl
        
        self.collectionView = collectionView
    }
    
    //MARK: create Collection View Layout
    private func layout(for sectionIndex: Int) -> NSCollectionLayoutSection {
        let section = CityWeatherSection.allCases[sectionIndex]
        
        switch section{
        case .current:
            let item = NSCollectionLayoutItem(layoutSize: .init(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(0.6)), subitems: [item])

            
            return NSCollectionLayoutSection(group: group)
        case .hourly:
            let item = NSCollectionLayoutItem(layoutSize: .init(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(
                widthDimension: .fractionalWidth(0.2),
                heightDimension: .fractionalWidth(0.3)), subitems: [item])
            
            group.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 5, bottom: 2, trailing: 5)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 40, trailing: 20)
            section.orthogonalScrollingBehavior = .continuous
            return section
            
        case .daily:
            let item = NSCollectionLayoutItem(layoutSize: .init(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(60)), subitems: [item])
            
            group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
            return NSCollectionLayoutSection(group: group)
        }
    }
    
    //MARK: Refresh control Action
    
    private lazy var refreshAction: UIAction = UIAction{ [weak self] _ in
        defer{
            self?.refreshControl.endRefreshing()
        }
        guard let self, let delegate = delegate else {return}
        
        delegate.reloadData()
        
    }
}

extension CurrentWeatherView: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        weatherForecastData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        switch weatherForecastData[section]{
        case .current:
            return 1
        case .hourly(let hourlyData):
            if hourlyData.count > 24{
                return 24
            }
            return hourlyData.count
        case .daily(let dailyData):
            return dailyData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch weatherForecastData[indexPath.section]{
        case .current(let currentData):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrentWeatherCollectionViewCell.cellIdentifier, for: indexPath) as? CurrentWeatherCollectionViewCell else {
                fatalError()
            }
            
            cell.configure(with: currentData)
            return cell
            
        case .hourly(let hourlyData):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCollectionViewCell.cellIdentifier, for: indexPath) as? HourlyWeatherCollectionViewCell else {
                fatalError()
            }
            
            cell.configure(with: hourlyData[indexPath.item])
            return cell
            
        case .daily(let dailyData):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyWeatherCollectionViewCell.cellIdentifier, for: indexPath) as? DailyWeatherCollectionViewCell else {
                fatalError()
            }
            
            cell.configure(with: dailyData[indexPath.item])
            return cell
        }
    }
}
