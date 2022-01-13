//
//  TodayCell.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//
import UIKit

final class TodayCell: ClearCell, ViewModelRepresentable {
    
    
    func populateSubviews(with viewModel: TodayCellVM) {
        todayTxtView.text = viewModel.overview
    }
    
   
    var viewModel: TodayCellVM? {
        didSet {
            if let vm = viewModel {
                
                populateSubviews(with: vm)
            }
           
        }
    }
    
    //MARK: Subviews
    private let todayTxtView: UITextView = {
        $0.textAlignment = .left
        $0.font = .overView
        $0.textColor = .weatherWhite
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false
        $0.isUserInteractionEnabled = false
        $0.textContainerInset = .zero
        $0.textContainer.maximumNumberOfLines = 4
        $0.textContainer.lineFragmentPadding = 0
        $0.textContainer.lineBreakMode = .byWordWrapping
        return $0
    }(UITextView())
    //MARK: Life cycle
    override func setup() {
        super.setup()
        addSubviewForAutoLayout(todayTxtView)
        addSeparator(to: .top, aboveSubview: todayTxtView)
        activateConstraints()
        
    }
    //MARK: Instance methods
    override func activateConstraints() {
        NSLayoutConstraint.activate([
            todayTxtView.leadingAnchor.constraint(equalTo: leadingAnchor),
            todayTxtView.trailingAnchor.constraint(equalTo: trailingAnchor),
            todayTxtView.centerYAnchor.constraint(equalTo: centerYAnchor)
            
        ])
        
    }
   
    
}
