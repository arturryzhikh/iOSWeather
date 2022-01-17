//
//  HourlyCell.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//
import UIKit

final class HourlyCell: TransparentCell ,ViewRepresentable {
    
    var viewModel: Home.ViewModels.HourlyItemViewModel? {
        didSet {
            
            if let vm = viewModel {
                populateSubviews(with: vm)
            }
        }
    }
    
    func populateSubviews(with viewModel: Home.ViewModels.HourlyItemViewModel) {
        hourLabel.text = viewModel.hour
        weatherImageView.image = UIImage(named: viewModel.iconName)
        temperatureLabel.text = viewModel.temperature
    }
    
    
    //MARK: Life Cycle
    override func setup() {
        activateConstraints()
    }
    
    
    override func activateConstraints() {
        addMultipleSubviews(hourLabel,weatherImageView,temperatureLabel)
        hourLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(weatherImageView.snp.top)
        }
        weatherImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo((Screen.height * 0.16)/3)
            make.centerX.equalToSuperview()
            
        }
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherImageView.snp.bottom)
            make.leading.bottom.trailing.equalToSuperview()
        }
//        addMultipleSubviews(vStack)
//        vStack.snp.makeConstraints { make in
//            make.top.leading.bottom.trailing.equalToSuperview()
//        }
        
    }
//    //MARK: Subviews
//    private lazy var vStack: UIStackView = {
//        $0.addArrangedSubview(hourLabel)
//        $0.addArrangedSubview(weatherImageView)
//        $0.addArrangedSubview(temperatureLabel)
//        $0.axis = .vertical
//        $0.alignment = .center
//        $0.distribution = .fill
//        $0.spacing = 1
//        return $0
//
//    }(UIStackView())
    
    let hourLabel: UILabel = { 
        return $0
    }(UILabel(font: .lightTemperature))
    
    private let temperatureLabel: UILabel = {
        return $0
    }(UILabel(font: .regularTemperature))
    
    
    private let weatherImageView: UIImageView = {
        
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    
}
