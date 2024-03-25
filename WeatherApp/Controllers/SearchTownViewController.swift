//
//  SearchTownViewController.swift
//  WeatherApp
//
//  Created by Евгений Беляков on 25.03.2024.
//

import UIKit

import MapKit
import CoreLocation

class SearchTownViewController: UIViewController {

    private let tableView: UITableView = UITableView()

    private let searchController = UISearchController(searchResultsController: nil)
    
    private var completer = MKLocalSearchCompleter()
    
    private var cityResults = [String]() {
        didSet {
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }
    
    private var dataSource: UITableViewDiffableDataSource<Int, String>?
    
    private var apiManager: ApiManager
    
    //MARK: Initializers
    init(apiManager: ApiManager){
        self.apiManager = apiManager
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Town Searcher"
        navigationItem.backButtonDisplayMode = .minimal
        setupSearchController()
        configureTableView()
        createDataSource()
        reloadData()
        completer.delegate = self
        completer.region = MKCoordinateRegion(.world)
        completer.pointOfInterestFilter = MKPointOfInterestFilter.excludingAll
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search town"
        
        self.navigationItem.searchController = searchController
//        self.definesPresentationContext = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableViewCell")
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func createDataSource() {
        dataSource = UITableViewDiffableDataSource<Int, String>(tableView: tableView){
            tableView, indexPath, townName in
            let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
            var content = cell.defaultContentConfiguration()
            content.text = townName
            cell.contentConfiguration = content
            
            return cell
        }
    }
    
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([1])
        snapshot.appendItems(cityResults, toSection: 1)
        
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
    
    
    
    func showWeatherForTappedCity(cityName: String) {
        let geoCoder = CLGeocoder()
        Task{
            do{
                let placemarks = try await geoCoder.geocodeAddressString(cityName)
                guard let placemark = placemarks.first else {return}
                guard let location = placemark.location else {return}
                
                let vc = CityWeatherViewController(apiManager: apiManager)
                vc.showForecast(for: Coordinates(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
                vc.setCityNameToNavBarTitle(by: location)
                navigationController?.pushViewController(vc, animated: false)
                
            } catch{
                print(error.localizedDescription)
            }
        }
    }
}

extension SearchTownViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showWeatherForTappedCity(cityName: cityResults[indexPath.row])
    }
}

extension SearchTownViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        completer.queryFragment = searchController.searchBar.text ?? ""
    }
}

extension SearchTownViewController: MKLocalSearchCompleterDelegate{
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        let results = completer.results.filter{ item in
            item.title != ""
        }
        var setOfCityResults: Set<String> = []
        for result in results {
            if result.title.contains(",") {
                let splitByComma = result.title.components(separatedBy: ",")
                if splitByComma.count > 0 {
                    if !setOfCityResults.contains(splitByComma[0]) {
                        setOfCityResults.insert(splitByComma[0])
                    }
                }
            }
        }
        if setOfCityResults.count > 0 {
            cityResults = Array(setOfCityResults)
        }
        
    }
}

