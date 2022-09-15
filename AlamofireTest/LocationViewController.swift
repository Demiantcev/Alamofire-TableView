//
//  LocationViewController.swift
//  AlamofireTest
//
//  Created by Кирилл Демьянцев on 07.09.2022.
//

import UIKit
import Alamofire

class LocationViewController: UIViewController {
    
    var locations: [Locations] = []
    private var searchedLocation: [Locations] = []
    
    private let searController = UISearchController(searchResultsController: nil)
    private var searching = false
    
    var tableView: UITableView = {
        var table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .black
        table.register(LocationTableViewCell.self, forCellReuseIdentifier: "Cell")
        return table
    }()
    
    let titleLabel: UILabel = {
       var label = UILabel()
        label.text = "Локации"
        label.font = UIFont(name: "Copperplate-Bold", size: 30)
        label.textColor = .orange
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var backButton: UIButton = {
       var button = UIButton()
        button.setTitle(" Назад", for: .normal)
        button.tintColor = .black
        button.setTitleColor(UIColor.black, for: .normal)
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.titleLabel?.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        return button
    }()
    
    @objc func back() {
        navigationController?.popToRootViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraint()
        setupNavigation()
        parsJSON()
        configureSearchController()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configureSearchController() {
        searController.loadViewIfNeeded()
        searController.searchResultsUpdater = self
        searController.searchBar.delegate = self
        searController.obscuresBackgroundDuringPresentation = false
        searController.searchBar.enablesReturnKeyAutomatically = false
        searController.searchBar.returnKeyType = UIReturnKeyType.done
        searController.searchBar.barStyle = .black
        self.navigationItem.searchController = searController
        self.navigationItem.hidesSearchBarWhenScrolling = true
        definesPresentationContext = true
        searController.searchBar.placeholder = "Поиск"
    }
    
    private func parsJSON() {
        AF.request("https://rickandmortyapi.com/api/location").responseJSON { responseJSON in
            switch responseJSON.result {
            case .success(let value):

                let itemObject = value as? [String: Any]

                guard let arrayOfItems = itemObject?["results"] as? [[String: Any]] else { return }
                    for itm in arrayOfItems {

                        let item = Locations(name: itm["name"] as! String,
                                             type: itm["type"] as! String,
                                             dimension: itm["dimension"] as! String)
                        
                        self.locations.append(item)
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }

            case .failure(let error):
                print(error)
            }
        }
    }
    private func setupNavigation() {
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.systemOrange]
        navigationController?.hidesBarsOnSwipe = true
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    private func setupConstraint() {
        
        view.addSubview(tableView)
        tableView.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            backButton.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 13),
            backButton.leadingAnchor.constraint(equalTo: tableView.leadingAnchor, constant: 10)
        ])
    }
}
extension LocationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchedLocation.count
        } else {
            return locations.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! LocationTableViewCell
        if searching {
            configureCell(location: searchedLocation, cell: cell, for: indexPath)
            
        } else {
            configureCell(location: locations, cell: cell, for: indexPath)
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 130
        }
        return 100
    }
    
    func configureCell(location: [Locations], cell: LocationTableViewCell, for indexPath: IndexPath) {
        let item = location[indexPath.row]
        cell.nameLabel.text = "\(item.name)"
        cell.dimensionLabelTwo.text = "\(item.dimension)"
        cell.typeLabelTwo.text = "\(item.type)"
    }
}
extension LocationViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchedLocation.removeAll()
        tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        if !searchText.isEmpty {
            searching = true
            searchedLocation.removeAll()
            for char in locations {
                if char.name.lowercased().contains(searchText.lowercased()) {
                    searchedLocation.append(char)
                }
            }
        } else {
            searching = false
            searchedLocation.removeAll()
            searchedLocation = locations
            
        }
        tableView.reloadData()
    }
}
