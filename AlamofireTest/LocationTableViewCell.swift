//
//  LocationTableViewCell.swift
//  AlamofireTest
//
//  Created by Кирилл Демьянцев on 07.09.2022.
//

import UIKit

class LocationTableViewCell: UITableViewCell {
    
    let nameLabel: UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let typeLabel: UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.text = "type:"
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let typeLabelTwo: UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dimensionLabel: UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.text = "dimension:"
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dimensionLabelTwo: UILabel = {
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
        
        [nameLabel, typeLabel, typeLabelTwo, dimensionLabel, dimensionLabelTwo].forEach {
            self.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
        
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            nameLabel.bottomAnchor.constraint(equalTo: typeLabel.topAnchor, constant: -5),
            
            typeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            
            typeLabelTwo.leadingAnchor.constraint(equalTo: dimensionLabelTwo.leadingAnchor),
            
            dimensionLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 5),
            dimensionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            dimensionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            dimensionLabelTwo.topAnchor.constraint(equalTo: typeLabelTwo.bottomAnchor, constant: 5),
            dimensionLabelTwo.leadingAnchor.constraint(equalTo: dimensionLabel.trailingAnchor, constant: 5),
            dimensionLabelTwo.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

}
