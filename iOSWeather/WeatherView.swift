//
//  WeatherView.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//

import UIKit
import SnapKit

final class WeatherView: UIView {
    //MARK: Other Properties
    
    //MARK: Life Cycle
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        activateConstraints()
      
        
    }
    
    //MARK: Instance methods
    private func activateConstraints() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        
    }
    
    //create collection view
    let collectionView: UICollectionView = {
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.registerHeaders(CurrentHeader.self)
        $0.registerFooters(HourlyFooter.self)
        $0.registerCells(DailyCell.self, TodayCell.self, DetailCell.self, LinkCell.self)
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: WeatherFlowLayout()))
    
}


