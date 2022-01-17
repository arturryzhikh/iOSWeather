//
//  CityCell.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 17.01.2022.
//

import UIKit

class CityCell: UITableViewCell {

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        backgroundColor = .clear
        contentView.backgroundColor =  .clear
        textLabel?.textColor = .white
        detailTextLabel?.textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
