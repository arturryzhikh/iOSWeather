//
//  WeatherView.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//

import UIKit

final class WeatherView: UIView {
    //MARK: Other Properties
    
    //MARK: Life Cycle
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
        addSubviewsForAutoLayout([backgroundImage,collectionView,pageControlBar,line])
        activateConstraints()
        
        
    }
    
    //MARK: Instance methods
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            //background image
            backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImage.topAnchor.constraint(equalTo: topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            //page control bar
            pageControlBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            pageControlBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            pageControlBar.bottomAnchor.constraint(equalTo: bottomAnchor),
            pageControlBar.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.07),
            //white line above page control bar
            line.leadingAnchor.constraint(equalTo: pageControlBar.leadingAnchor),
            line.trailingAnchor.constraint(equalTo: pageControlBar.trailingAnchor),
            line.heightAnchor.constraint(equalToConstant: 0.75),
            line.topAnchor.constraint(equalTo: pageControlBar.topAnchor),
            //collection view
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: pageControlBar.topAnchor)
        ])
    }
    //MARK: Subviews:
    private let backgroundImage: UIImageView = {
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())
    private let line: UIView =  {
        $0.backgroundColor = .weatherWhite
        return $0
    }(UIView())
    //Page Control Bar
    private lazy var pageControlBar: UIView =  {
        $0.backgroundColor = .clear
        return $0
    }(UIView())
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


