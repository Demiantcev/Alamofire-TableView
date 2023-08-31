//
//  EpisodeViewController.swift
//  AlamofireTest
//
//  Created by Кирилл Демьянцев on 12.09.2022.
//

import UIKit
import Alamofire

class EpisodeViewController: UIViewController {
    
    var episode: [Episode] = []
    private var searchedEpisode: [Episode] = []
    
    private let searController = UISearchController(searchResultsController: nil)
    private var searching = false
    
    var tableView: UITableView = {
        var table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .black
        table.register(EpisodeTableViewCell.self, forCellReuseIdentifier: "Cell")
        return table
    }()
    
    let titleLabel: UILabel = {
       var label = UILabel()
        label.text = "Эпизоды"
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
        
        setupNavigation()
        setupConstraint()
        parsJSON()
        configureSearchController()
        
        tableView.dataSource = self
        tableView.delegate = self
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
        AF.request("https://rickandmortyapi.com/api/episode").responseJSON { responseJSON in
            switch responseJSON.result {
            case .success(let value):

                let itemObject = value as? [String: Any]

                guard let arrayOfItems = itemObject?["results"] as? [[String: Any]] else { return }
                
                    for itm in arrayOfItems {

                        let item = Episode(airDate: itm["air_date"] as! String,
                                           name: itm["name"] as! String,
                                           episode: itm["episode"] as! String)
                        self.episode.append(item)
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
extension EpisodeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchedEpisode.count
        } else {
            return episode.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EpisodeTableViewCell
        if searching {
            configureCell(episode: searchedEpisode, cell: cell, for: indexPath)
            
        } else {
            configureCell(episode: episode, cell: cell, for: indexPath)
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 130
        }
        return 100
    }
    
    func configureCell(episode: [Episode], cell: EpisodeTableViewCell, for indexPath: IndexPath) {
        let item = episode[indexPath.row]
        cell.nameLabel.text = "\(item.name)"
        cell.airDateLabelTwo.text = "\(item.airDate)"
        cell.episodeLabelTwo.text = "\(item.episode)"
    }
}
extension EpisodeViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchedEpisode.removeAll()
        tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        if !searchText.isEmpty {
            searching = true
            searchedEpisode.removeAll()
            for char in episode {
                if char.name.lowercased().contains(searchText.lowercased()) {
                    searchedEpisode.append(char)
                }
            }
        } else {
            searching = false
            searchedEpisode.removeAll()
            searchedEpisode = episode
            
        }
        tableView.reloadData()
    }
}
