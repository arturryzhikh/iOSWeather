//
//  WeatherView.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//

import UIKit
import SnapKit

public final class WeatherView: UIView {
    
    public override static var layerClass: AnyClass { return CAGradientLayer.self }
    //MARK: properties
    private var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }
    
    private func generateGradient() {
        let color1 = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1).cgColor
        let color2 = #colorLiteral(red: 0.1352660358, green: 0.6287184954, blue: 0.700309813, alpha: 1).cgColor
        gradientLayer.colors = [color1, color2]
    }
    //MARK: Life Cycle
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        activateConstraints()
        generateGradient()
    }
    
    //MARK: Instance methods
    private func activateConstraints() {
        addMultipleSubviews(collectionView,tabbar)
        
        collectionView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        tabbar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.snp.bottomMargin)
        }
 
    }

    lazy var tabbar: UITabBar = {
        $0.addSeparator(to: .top, aboveSubview: $0)
        let search = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        $0.items = [search]
        return $0
    }(UITabBar())
    //create collection view
    lazy var collectionView: UICollectionView = {
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.registerHeaders(CurrentHeader.self)
        $0.registerFooters(HourlyFooter.self)
        $0.registerCells(DailyCell.self, TodayCell.self, DetailCell.self)
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: WeatherFlowLayout()))
    
}


