//
//  ClearCell.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//
import UIKit

///Base class for all custom transperent UI Collection View Cells
public class TransparentCell: UICollectionViewCell  {
    override init(frame: CGRect) {
        super.init(frame:frame)
        setup()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    ///Placeholder method to incapsulate initial setup of a view.
    ///This method calls by suprclass during initialization
    ///Default implementation of this method makes cell transparent, clips to bounds, turn off user intreactions
    ///Override this method to provide your initial setup for view and subviews
    func setup() {
        clipsToBounds = true
        contentView.backgroundColor =  .clear
        isUserInteractionEnabled = false
    }
    ///Placeholder method to incapsulate autoLayout code
    ///Default implementation of this method does nothing
    ///Override this method to provide your initial setup for auto layout constraints
    func activateConstraints() {
        
    }
    
    
}

enum SeparatorPosition {
    case bottom
    case top
}

extension TransparentCell {
    
    func addSeparator(to position: SeparatorPosition, color: UIColor = .weatherTransparent,
                      of height: CGFloat = 0.75, aboveSubview: UIView) {
        guard self.contains(aboveSubview)  else {
            print("aboveSubview \(aboveSubview.description) is not added into view heiarchy. Try to add it first")
            return
        }
        let separator = UIView()
        separator.backgroundColor = color
        separator.translatesAutoresizingMaskIntoConstraints = false
        insertSubview(separator, aboveSubview: aboveSubview)
        separator.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(height)
            switch position {
            case .top:
                make.top.equalToSuperview()
            case .bottom:
                make.bottom.equalToSuperview()
            }
            
        }
        
    }
}
