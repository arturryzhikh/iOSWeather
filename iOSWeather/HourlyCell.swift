//
//  HourlyCell.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//
import UIKit

final class HourlyCell: TranaperentCell ,ViewModelRepresentable {
    
    var viewModel: HourlyItemViewModel? {
        didSet {
            
            if let vm = viewModel {
                populateSubviews(with: vm)
            }
        }
    }
    
    func populateSubviews(with viewModel: HourlyItemViewModel) {
        hourLabel.text = viewModel.hour
        weatherEmojiLabel.text = viewModel.weatherEmoji
        temperatureLabel.text = viewModel.temperature
    }
    
    
    //MARK: Life Cycle
    override func setup() {
        activateConstraints()
    }
    
    
    override func activateConstraints() {
        addSubview(vStack)
        vStack.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        
    }
    //MARK: Subviews
    private lazy var vStack: UIStackView = {
        $0.addArrangedSubview(hourLabel)
        $0.addArrangedSubview(weatherEmojiLabel)
        $0.addArrangedSubview(temperatureLabel)
        $0.axis = .vertical
        $0.alignment = .center
        $0.distribution = .fill
        $0.spacing = 4
        return $0
        
    }(UIStackView())
    
    let hourLabel: UILabel = { 
        return $0
    }(UILabel(font: .lightTemperature))
    
    
    private let temperatureLabel: UILabel = {
        return $0
    }(UILabel(font: .regularTemperature))
    
    
    private let weatherEmojiLabel: UILabel = {
        return $0
    }(UILabel(font: .weatherEmoji))
    
    
}
