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
        super.setup()
        addSubviewForAutoLayout(linkTxtView)
        addSeparator(to: .top, aboveSubview: linkTxtView)
        activateConstraints()
        
    }
    //MARK: Instance methods
    override func activateConstraints() {
        NSLayoutConstraint.activate([
            linkTxtView.leadingAnchor.constraint(equalTo: leadingAnchor),
            linkTxtView.trailingAnchor.constraint(equalTo: trailingAnchor),
            linkTxtView.centerYAnchor.constraint(equalTo: centerYAnchor)
            
        ])
    }
  
}
