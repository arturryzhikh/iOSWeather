//
//  DetailCell.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//
import UIKit

final class DetailCell: TransparentCell , ViewModelRepresentable {
    
    var viewModel: DetailCellVM? {
        
        didSet {
            if let vm = viewModel {
                populateSubviews(with: vm)
            }
        }
    }
    func populateSubviews(with viewModel: DetailCellVM) {
        detailLabel.text = viewModel.detail
        valueLabel.text = viewModel.value
    }
    //MARK: Other properties
    
    //MARK: Subviews
    let detailLabel: UILabel = {
        return $0
    }(UILabel(transparentText: true, alignment: .left, font: .extendedInfoTitle))
    
    private let valueLabel: UILabel = {
        return $0
    }(UILabel(transparentText: false, alignment: .left, font: .extendedInfoValue))
    
    //MARK: life Cycle
    override func setup() {
        activateConstraints()
        addSeparator(to: .top, aboveSubview: valueLabel)
        
    }
    
    
    private lazy var vStack: UIStackView = {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.distribution = .fillProportionally
        $0.spacing = 0
        return $0
        
    }(UIStackView(arrangedSubviews:[detailLabel, valueLabel]))
    
    
    override func activateConstraints() {
        addSubview(vStack)
        vStack.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
        }
        
    }
    
}

