//
//  DailyCell.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//

import UIKit

final class DailyCell: ClearCell {
    
    var viewModel: DailyCellVM? {
        
        didSet {
            if let vm = viewModel {
                populateSubviews(with: vm)
            }
        }
    }
    
    func populateSubviews(with viewModel: DailyCellVM) {
        dayLabel.text = viewModel.day
        temperatureHighLabel.text = viewModel.temperatureHigh
        temperatureLowLabel.text = viewModel.temperatureLow
        weatherEmojiLabel.text = viewModel.weatherEmoji
        percentageLabel.text = viewModel.percentage
    }
    //MARK: Other properties
    
    //MARK: Subviews
    let dayLabel: UILabel = {
        $0.font = .regularTemperature
        $0.textColor = .weatherWhite
        return $0
    }(UILabel())
    
    private let temperatureHighLabel: UILabel = {
        return $0
    }(UILabel(font: .regularTemperature))
    
    
    private let temperatureLowLabel: UILabel = {
       return $0
    }(UILabel(transparentText: true, alignment: .center, font: .lightTemperature))
    
    private let weatherEmojiLabel: UILabel = {
        return $0
    }(UILabel(font: .weatherEmoji))
    
    private let percentageLabel: UILabel = {
        $0.textColor = .percentage
        return $0
    }(UILabel(font: .extendedInfoTitle))
    
    private lazy var weatherEmojiStack: UIStackView = {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.distribution = .fill
        $0.spacing = Screen.width * 0.025
        return $0
    }(UIStackView(arrangedSubviews: [weatherEmojiLabel,percentageLabel]))
    
    private lazy var temperatureStack: UIStackView = {
        $0.axis = .horizontal
        $0.alignment = .trailing
        $0.distribution = .fillEqually
        $0.spacing = 0
        return $0
    }(UIStackView(arrangedSubviews:[temperatureHighLabel,temperatureLowLabel]))
    //MARK: life Cycle
    
    override func setup() {
        super.setup()
        addSubviewsForAutoLayout([dayLabel,weatherEmojiStack,temperatureStack])
        activateConstraints()
        
    }
    
    override func activateConstraints() {
        NSLayoutConstraint.activate([
            dayLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            dayLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            weatherEmojiStack.leadingAnchor.constraint(equalTo: centerXAnchor,constant: -Screen.width * 0.1),
            weatherEmojiStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            temperatureStack.leadingAnchor.constraint(equalTo: centerXAnchor,constant: Screen.width * 0.15),
            temperatureStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            temperatureStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            
        ])
    }
 
}
