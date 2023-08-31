//
//  CharactersViewController.swift
//  AlamofireTest
//
//  Created by Кирилл Демьянцев on 05.08.2022.
//

import UIKit
import Alamofire
import AlamofireImage
import Combine

class CharactersViewController: UIViewController {
    
    private var result: [Characters] = []
    private var searchedCharacters: [Characters] = []
    
    private let searController = UISearchController(searchResultsController: nil)
    private var searching = false
    
    var tableView: UITableView = {
        var table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .black
        table.register(CharactersTableViewCell.self, forCellReuseIdentifier: "Cell")
        return table
    }()
    
    let titleLabel: UILabel = {
       var label = UILabel()
        label.text = "Персонажи"
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
        
        tableView.dataSource = self
        tableView.delegate = self
        parsJSON()
        
        // MARK: - Search
        configureSearchController()
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
    
    private func setupNavigation() {
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.systemOrange]
        navigationItem.titleView = titleLabel
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
            backButton.leadingAnchor.constraint(equalTo: tableView.leadingAnchor, constant: 10),
        ])
    }
    
    func parsJSON() {
        AF.request("https://rickandmortyapi.com/api/character").responseJSON { responseJSON in
            switch responseJSON.result {
            case .success(let value):

                let itemObject = value as? [String: Any]

                guard let arrayOfItems = itemObject?["results"] as? [[String: Any]] else { return }
                for itm in arrayOfItems {
                    
                    let item = Characters(name: itm["name"] as! String,
                                          species: itm["species"] as! String,
                                          gender: itm["gender"] as! String,
                                          status: itm["status"] as! String,
                                          image: itm["image"] as! String)
                    
                    self.result.append(item)
                }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }

            case .failure(let error):
                print(error)
            }
        }
    }
}
extension CharactersViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchedCharacters.count
        } else {
            return result.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CharactersTableViewCell
        
        if searching {
            configureCell(characters: searchedCharacters, cell: cell, for: indexPath)
            parseImage(characters: searchedCharacters, cell: cell, for: indexPath)
        } else {
            
            configureCell(characters: result, cell: cell, for: indexPath)
            parseImage(characters: result, cell: cell, for: indexPath)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 150
        }
        return 100
    }
    
    func configureCell(characters: [Characters], cell: CharactersTableViewCell, for indexPath: IndexPath) {
        let item = characters[indexPath.row]
        cell.nameLabel.text = "\(item.name)"
        cell.genderLabelTwo.text = "\(item.gender)"
        cell.speciesLabelTwo.text = "\(item.species)"
        cell.statusLabelTwo.text = "\(item.status)"
    }
    
    func parseImage(characters: [Characters], cell: CharactersTableViewCell,for indexPath: IndexPath) {
        let urlImage = characters[indexPath.row].image
        AF.request(urlImage).responseImage { (response) in
            
            if let image = response.value {
                DispatchQueue.main.async {
                    cell.fotoImage.image = image
                }
            }
        }
    }
}
extension CharactersViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchedCharacters.removeAll()
        tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        if !searchText.isEmpty {
            searching = true
            searchedCharacters.removeAll()
            for char in result {
                if char.name.lowercased().contains(searchText.lowercased()) {
                    searchedCharacters.append(char)
                }
            }
        } else {
            searching = false
            searchedCharacters.removeAll()
            searchedCharacters = result
            
        }
        tableView.reloadData()
    }
}
