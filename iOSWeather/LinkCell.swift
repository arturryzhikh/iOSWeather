//
//  LinkCell.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//
import UIKit

final class LinkCell: ClearCell, ViewModelRepresentable {
    
    var viewModel: LinkCellVM? {
        
        willSet {
            if let vm = newValue {
                populateSubviews(with:vm )
            }
        }
        
    }
    func populateSubviews(with viewModel: LinkCellVM) {
        linkTxtView.attributedText = viewModel.linkAttributedString
    }
    //MARK: Subviews
    private let linkTxtView: UITextView = {
        $0.font = .overView
        return $0
    }(UITextView())
    
    //MARK: Life cycle
    override func setup() {
        activateConstraints()
        
    }
    //MARK: Instance methods
    override func activateConstraints() {
        addSubview(linkTxtView)
        addSeparator(to: .top, aboveSubview: linkTxtView)
        linkTxtView.snp.makeConstraints { make in
            make.centerY.leading.trailing.equalToSuperview()
        }
        
    }
    
}
