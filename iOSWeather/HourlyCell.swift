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
            make.height.equalTo(frame.height)
            make.width.equalTo(weatherImageView.snp.height)
            make.centerX.equalToSuperview()
        }
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherImageView.snp.bottom)
            make.leading.bottom.trailing.equalToSuperview()
        }
        
    }
    let hourLabel: UILabel = {
        return $0
    }(UILabel(font: .temperatureLight))
    
    private let temperatureLabel: UILabel = {
        return $0
    }(UILabel(font: .temperatureRegular))
    
    
    private let weatherImageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    
}
