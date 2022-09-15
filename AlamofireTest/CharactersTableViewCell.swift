//
//  CharactersTableViewCell.swift
//  AlamofireTest
//
//  Created by Кирилл Демьянцев on 05.08.2022.
//

import UIKit

class CharactersTableViewCell: UITableViewCell {
    
        let fotoImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let nameLabel: UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 23)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
        let genderLabel: UILabel = {
        var label = UILabel()
        label.text = "gender:"
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
        let genderLabelTwo: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
        let speciesLabel: UILabel = {
        var label = UILabel()
        label.text = "species:"
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
        let speciesLabelTwo: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
        let statusLabel: UILabel = {
        var label = UILabel()
        label.text = "status:"
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
        let statusLabelTwo: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupConstraints()
        self.backgroundColor = .systemGray6
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupConstraints() {
        
        self.contentView.addSubview(fotoImage)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(genderLabel)
        self.contentView.addSubview(genderLabelTwo)
        self.contentView.addSubview(speciesLabel)
        self.contentView.addSubview(speciesLabelTwo)
        self.contentView.addSubview(statusLabel)
        self.contentView.addSubview(statusLabelTwo)
        
        NSLayoutConstraint.activate([
            
            fotoImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            fotoImage.heightAnchor.constraint(equalToConstant: 100),
            fotoImage.widthAnchor.constraint(equalToConstant: 100),
            fotoImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: fotoImage.trailingAnchor, constant: 10),
            
            genderLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 1),
            genderLabel.leadingAnchor.constraint(equalTo: fotoImage.trailingAnchor, constant: 10),
            
            genderLabelTwo.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 1),
            genderLabelTwo.leadingAnchor.constraint(equalTo: genderLabel.trailingAnchor, constant: 10),
            
            speciesLabel.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 1),
            speciesLabel.leadingAnchor.constraint(equalTo: fotoImage.trailingAnchor, constant: 10),
            
            speciesLabelTwo.topAnchor.constraint(equalTo: genderLabelTwo.bottomAnchor, constant: 1),
            speciesLabelTwo.leadingAnchor.constraint(equalTo: genderLabelTwo.leadingAnchor),
            
            statusLabel.topAnchor.constraint(equalTo: speciesLabel.bottomAnchor, constant: 1),
            statusLabel.leadingAnchor.constraint(equalTo: fotoImage.trailingAnchor, constant: 10),
            statusLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            statusLabelTwo.leadingAnchor.constraint(equalTo: genderLabelTwo.leadingAnchor),
            statusLabelTwo.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            
        ])
    }
}
