//
//  ViewController.swift
//  AlamofireTest
//
//  Created by Кирилл Демьянцев on 04.08.2022.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    var colorButtonRandom: [UIColor] = [.purple, .green, .blue, .systemPink, .orange, .red]
    
    lazy var characterButton: UIButton = {
       var button = UIButton()
        button.setTitle("Персонажи", for: .normal)
        button.setImage(UIImage(systemName: "person.2"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 33)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapCharacterButton), for: .touchUpInside)
        return button
    }()
    
    @objc func tapCharacterButton(sender: Any) {
        UIView.animate(withDuration: 1, delay: 0) { [self] in
            characterButton.backgroundColor = colorButtonRandom.randomElement()
            characterButton.backgroundColor = .systemGray5
        }
        self.navigationController?.pushViewController(CharactersViewController(), animated: true)
    }
    
    lazy var locationsButton: UIButton = {
       var button = UIButton()
        button.setTitle(" Локации", for: .normal)
        button.setImage(UIImage(systemName: "globe.americas"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 33)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapLocationsButton), for: .touchUpInside)
        return button
    }()
    
    @objc func tapLocationsButton() {
        UIView.animate(withDuration: 1, delay: 0) { [self] in
            locationsButton.backgroundColor = colorButtonRandom.randomElement()
            locationsButton.backgroundColor = .systemGray5
        }
        self.navigationController?.pushViewController(LocationViewController(), animated: true)
    }
    
    lazy var episodesButton: UIButton = {
       var button = UIButton()
        button.setTitle(" Эпизоды", for: .normal)
        button.setImage(UIImage(systemName: "play.tv"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 33)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapEpisodesButton), for: .touchUpInside)
        button.layer.zPosition = .infinity
        return button
    }()
    
    @objc func tapEpisodesButton() {
        UIView.animate(withDuration: 1, delay: 0) { [self] in
            episodesButton.backgroundColor = colorButtonRandom.randomElement()
            episodesButton.backgroundColor = .systemGray5
        }
        self.navigationController?.pushViewController(EpisodeViewController(), animated: true)
    }
    
    var stackButton: UIStackView = {
       var stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let titleLabel: UILabel = {
        var label = UILabel()
        label.text = "The Rick and Morty"
        label.font = UIFont(name: "Copperplate-Bold", size: 30)
        label.textColor = .orange
//        label.backgroundColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    let titleView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
    
        setupConstraint()
    }
    
    private func setupConstraint() {
        
        view.addSubview(titleView)
        view.addSubview(stackButton)
        titleView.addSubview(titleLabel)
        stackButton.addArrangedSubview(characterButton)
        stackButton.addArrangedSubview(locationsButton)
        stackButton.addArrangedSubview(episodesButton)
        
        NSLayoutConstraint.activate([
            
            titleView.topAnchor.constraint(equalTo: view.topAnchor),
            titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleView.heightAnchor.constraint(equalToConstant: 100),
            
            titleLabel.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor, constant: 20),
            
            stackButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackButton.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            characterButton.heightAnchor.constraint(equalToConstant: 70),
            locationsButton.heightAnchor.constraint(equalToConstant: 70),
            episodesButton.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
}
