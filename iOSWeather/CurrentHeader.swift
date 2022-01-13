//
//  CurrentHeader.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//
import UIKit
import SnapKit

final class CurrentHeader: ClearCell {
    
    //MARK:Properties
    
    
    static var defaultHeight: CGFloat {
        Screen.height * 0.453
    }
    static var minimumHeight: CGFloat {
        Screen.height * 0.143
    }
    
    ///Calculates alpha of temperature and high low labels depending on view height
    private var computedAlpha: CGFloat {
        let transparentY = temperatureLabel.frame.height + temperatureLabel.frame.origin.y
        return max((frame.height - transparentY) / (CurrentHeader.defaultHeight - transparentY), 0)
    }
    
    private var topConstraint: Constraint?
    private var topPadding: CGFloat {
        return frame.height * 0.3
    }
    //MARK: Life cycle
    override func setup() {
        activateConstraints()
    }
    private lazy var stack: UIStackView = {
        $0.addArrangedSubview(locationLabel)
        $0.addArrangedSubview(outlineLabel)
        $0.addArrangedSubview(temperatureLabel)
        $0.addArrangedSubview(temperatureRangeLabel)
        $0.axis = .vertical
        $0.distribution = .fill
        return $0
    }(UIStackView())
    
    override func activateConstraints() {
        addMultipleSubviews(
            stack
            
        )
        
        stack.snp.makeConstraints { make in
            topConstraint =  make.top.equalTo(self.snp.top).offset(topPadding).constraint
            make.leading.trailing.equalToSuperview()
        }
        
        
    }
    
    override func layoutSubviews() {
        //update top constraint when view changes during scrolling
        topConstraint?.update(offset: topPadding)
        temperatureRangeLabel.alpha = computedAlpha
        temperatureLabel.alpha = computedAlpha
    }
    
    //MARK: Subviews
    let locationLabel: UILabel = {
        $0.text = "- -"
        return $0
    }(UILabel(transparentText: false,font: .locationLabel))
    
    private let outlineLabel: UILabel = {
        return $0
    }(UILabel(font: .lightTemperature))
    
    private let temperatureLabel: UILabel = {
        return $0
    }(UILabel(font: .hugeTemperature))
    
    private let temperatureRangeLabel: UILabel = {
        return $0
    }(UILabel(font: .lightTemperature))
    
    var viewModel: CurrentHeaderVM? {
        
        didSet {
            if let vm = viewModel {
                populateSubviews(with: vm)
            }
            
        }
    }
    
    
    func populateSubviews(with viewModel: CurrentHeaderVM) {
        locationLabel.text = viewModel.location
        outlineLabel.text = viewModel.outline
        temperatureLabel.text = viewModel.temperature
        temperatureRangeLabel.text = viewModel.highLowTemp
    }
    
    
}
