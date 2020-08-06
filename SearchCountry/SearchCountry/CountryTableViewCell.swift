//
//  CountryTableViewCell.swift
//  SearchCountry
//
//  Created by Murat Merekov on 03.08.2020.
//  Copyright © 2020 Murat Merekov. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    
    var countryName: UILabel!
    var capitalName: UILabel!
    var timzone: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        countryName = UILabel()
        countryName.translatesAutoresizingMaskIntoConstraints = false
        countryName.font = UIFont(name: "Helvetica-Bold", size: 14)
        contentView.addSubview(countryName)
        
        capitalName = UILabel()
        capitalName.translatesAutoresizingMaskIntoConstraints = false
        capitalName.font = UIFont(name: "Helvetica", size: 18)
        contentView.addSubview(capitalName)
        
        timzone = UILabel()
        timzone.translatesAutoresizingMaskIntoConstraints = false
        timzone.font = UIFont(name: "Helvetica-Bold", size: 18)
        contentView.addSubview(timzone)
        
        setupConstraints()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            capitalName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            capitalName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            capitalName.heightAnchor.constraint(equalToConstant: 18),
            
            countryName.topAnchor.constraint(equalTo: capitalName.bottomAnchor, constant: 5),
            countryName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            countryName.heightAnchor.constraint(equalToConstant: 15),
            
            timzone.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            timzone.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configure(_ detail: Detail ){
        capitalName.text = detail.capital
        countryName.text = detail.name
        timzone.text = detail.timezones[0]
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
