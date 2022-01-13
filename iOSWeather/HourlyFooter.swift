//
//  HourlyFooter.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//
import UIKit

final class HourlyFooter: ClearCell, UICollectionViewDelegate {

    //MAKR: Static properties
    
    var viewModel: HourlyFooterVM? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    static var defaultHeight: CGFloat {
        Screen.height * 0.15
    }
    //MARK: Subviews
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.registerCells(HourlyCell.self)
        let horizontalInset = Screen.width * 0.05
        collectionView.contentInset = UIEdgeInsets(top: 0, left: horizontalInset, bottom: 0, right: horizontalInset)
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = horizontalInset
            layout.minimumInteritemSpacing = 0
            layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            
        }
        return collectionView
    }()
    
    //MARK: Other Properties
    //MARK: Life cycle
    override func setup() {
        super.setup()
        isUserInteractionEnabled = true//switch back property to allow collection view to be scrolling
        addSubviewForAutoLayout(collectionView)
        addSeparator(to: .top, aboveSubview: collectionView)
        addSeparator(to: .bottom, aboveSubview: collectionView)
        activateConstraints()
        
        
    }
    //MARK:Instance methods
    override func activateConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
  
}
////MARK: DataSource
extension HourlyFooter: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        return viewModel?.items.count ?? 0
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyCell.description(), for: indexPath) as! HourlyCell
        
        cell.viewModel = viewModel?.items[indexPath.item]
       
        return cell
    }
    
    
}
//MARK: Delegate Flow Layout

extension HourlyFooter: UICollectionViewDelegateFlowLayout {
    
}
