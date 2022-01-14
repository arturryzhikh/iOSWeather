//
//  DailyCell.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//

import UIKit

final class DailyCell: TransparentCell {
    
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
        activateConstraints()
        
    }
    private lazy var stack: UIStackView = {
        $0.addArrangedSubview(dayLabel)
        $0.addArrangedSubview(weatherEmojiStack)
        $0.addArrangedSubview(temperatureStack)
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        return $0
    }(UIStackView())
    
    override func activateConstraints() {
        addMultipleSubviews(
            stack

        )
        stack.snp.makeConstraints { make in
            make.centerY.leading.trailing.equalToSuperview()

        
        }
    
    }
}
