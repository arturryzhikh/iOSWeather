//
//  LinkCell.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//
import UIKit

final class LinkCell: TransparentCell, ViewRepresentable {
    
    var viewModel: LinkCellVM? {
        
        willSet {
            if let vm = newValue {
                populateSubviews(with:vm )
            }
        }
        
    }
    
    func populateSubviews(with viewModel: LinkCellVM) {
        linkLabel.attributedText = viewModel.link
    }
    //MARK: Subviews
    private let linkLabel: UILabel = {
        $0.font = .regularTemperature
        $0.numberOfLines = 0
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    //MARK: Life cycle
    override func setup() {
        activateConstraints()
        
    }
    //MARK: Instance methods
    override func activateConstraints() {
        addSubview(linkLabel)
        addSeparator(to: .top, aboveSubview: linkLabel)
        linkLabel.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        
    }
    
}

