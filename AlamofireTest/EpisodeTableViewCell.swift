//
//  EpisodeTableViewCell.swift
//  AlamofireTest
//
//  Created by Кирилл Демьянцев on 12.09.2022.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {
    
    let nameLabel: UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let airDateLabel: UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.text = "air date:"
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let airDateLabelTwo: UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let episodeLabel: UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.text = "episode:"
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let episodeLabelTwo: UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        setupConstraint()
        self.backgroundColor = .systemGray6
    }
    
    func setupConstraint() {
        
        self.addSubview(nameLabel)
        self.addSubview(episodeLabel)
        self.addSubview(episodeLabelTwo)
        self.addSubview(airDateLabel)
        self.addSubview(airDateLabelTwo)
        
        NSLayoutConstraint.activate([
        
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            nameLabel.bottomAnchor.constraint(equalTo: airDateLabel.topAnchor, constant: -5),
            
            airDateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            
            airDateLabelTwo.leadingAnchor.constraint(equalTo: airDateLabel.trailingAnchor, constant: 5),
            
            episodeLabel.topAnchor.constraint(equalTo: airDateLabel.bottomAnchor, constant: 5),
            episodeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            episodeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            episodeLabelTwo.topAnchor.constraint(equalTo: airDateLabelTwo.bottomAnchor, constant: 5),
            episodeLabelTwo.leadingAnchor.constraint(equalTo: episodeLabel.trailingAnchor, constant: 5),
            episodeLabelTwo.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
