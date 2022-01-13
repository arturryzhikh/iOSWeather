//
//  ClearCell.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//
import UIKit

///Base class for all Custom UI Collection View Cells
public class ClearCell: UICollectionViewCell  {
   
    override init(frame: CGRect) {
        super.init(frame:frame)
        setup()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    ///This is placeholder method to incapsulate initial setup of a view.
    ///This method calls during initialization within overriden init(frame: CGRect)
    ///Default implementation of this method does nothing
    ///Override this method to provide your initial setup for view and subviews
    func setup() {
        clipsToBounds = true
        backgroundColor =  .clear
        isUserInteractionEnabled = false
    }
    ///This is placeholder method to incapsulate autoLayout code
    ///Default implementation of this method does nothing
    ///Override this method to provide your initial setup for auto layout constraints
    func activateConstraints() {
        
    }
    
    
}
