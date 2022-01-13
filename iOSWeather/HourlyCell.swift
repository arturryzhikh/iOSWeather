//
//  HourlyCell.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//
import UIKit

final class HourlyCell: ClearCell ,ViewModelRepresentable {
    
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
        super.setup()
        addSubviewForAutoLayout(vStack)
        activateConstraints()
        
        
    }
    //MARK: Subviews
    private lazy var vStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            hourLabel,
            weatherEmojiLabel,
            temperatureLabel
        ])
        sv.axis = .vertical
        sv.alignment = .center
        sv.distribution = .fill
        sv.spacing = 4
        return sv
        
    }()
    let hourLabel: UILabel = { 
        return $0
    }(UILabel(font: .lightTemperature))
    
    
    private let temperatureLabel: UILabel = {
        return $0
    }(UILabel(font: .regularTemperature))
    
    
    private let weatherEmojiLabel: UILabel = {
        return $0
    }(UILabel(font: .weatherEmoji))
    
    
    override func activateConstraints() {
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: topAnchor),
            vStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            vStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
}
