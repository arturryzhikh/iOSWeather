//
//  CurrentHeader.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//
import UIKit

final class CurrentHeader: ClearCell, ViewModelRepresentable {
    
    var viewModel: CurrentHeaderVM? {
        
        didSet {
            if let vm = viewModel {
                populateSubviews(with: vm)
            }
            
        }
    }
    
    //MARK: Static  Properties
    static var defaultHeight: CGFloat {
        Screen.height * 0.453
    }
    static var minimumHeight: CGFloat {
        Screen.height * 0.143
    }
    //MARK: Other Properties
    private var computedAlpha: CGFloat { //calculate alpha of temperature and high low labels depending on view height
        let transparentY = temperatureLabel.frame.height + temperatureLabel.frame.origin.y
        return max((frame.height - transparentY) / (CurrentHeader.defaultHeight - transparentY), 0)
    }
    private var topConstraint: NSLayoutConstraint?
    private var topPadding: CGFloat {
        return frame.height * 0.3
    }
    //MARK: Life cycle
    override func setup() {
        activateConstraints()
    }
    override func activateConstraints() {
        addMultipleSubviews(
            locationLabel,
            descriptionLabel,
            temperatureLabel,
            highLowLabel
        )
        
        topConstraint = locationLabel.topAnchor.constraint(equalTo: topAnchor,constant: topPadding)
        topConstraint?.isActive = true
        locationLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.trailing.equalToSuperview()
            
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom)
            make.centerX.equalToSuperview()
        }
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom)
            make.centerX.equalToSuperview()
        }
        highLowLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
    }
    
    override func layoutSubviews() {
        //update top constraint when view changes during scrolling
        topConstraint?.constant = topPadding
        highLowLabel.alpha = computedAlpha
        temperatureLabel.alpha = computedAlpha
    }
    //MARK: Subviews
    let locationLabel: UILabel = {
        $0.text = "- -"
        return $0
    }(UILabel(transparentText: false,font: .locationLabel))
    
    private let descriptionLabel: UILabel = {
        return $0
    }(UILabel(font: .lightTemperature))
    
    private let temperatureLabel: UILabel = {
        return $0
    }(UILabel(font: .hugeTemperature))
    
    private let highLowLabel: UILabel = {
        return $0
    }(UILabel(font: .lightTemperature))
    
    
    func populateSubviews(with viewModel: CurrentHeaderVM) {
        locationLabel.text = viewModel.location
        descriptionLabel.text = viewModel.description
        temperatureLabel.text = viewModel.temperature
        highLowLabel.text = viewModel.highLowTemp
    }
    
    
    
    
    
}
