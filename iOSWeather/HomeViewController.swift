//
//  HomeViewController.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 14.01.2022.
//  Copyright (c) 2022 Artur Ryzhikh. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import CoreLocation
import SnapKit

protocol HomeDisplayLogic: AnyObject {
    func displayWeather(_ viewModel: Home.ViewModels.ViewModel)
    func displayError(message: String)
    
}

final class HomeViewController: UIViewController, HomeDisplayLogic {
    
    //MARK: Other Properties
    private let locationManager: CLLocationManager = CLLocationManager()
    private var homeViewModel = Home.ViewModels.ViewModel()
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
        
    }
    private func getWeather(for location: CLLocation) {
        activityIndicator.startAnimating()
        let coord = Coord(lat: "\(location.coordinate.latitude)",
                          lon: "\(location.coordinate.longitude)")
        interactor?.getWeather(for: coord)
    }
    func getCityForecast() {
        activityIndicator.startAnimating()
        interactor?.getCityForecast()
    }
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = HomeInteractor()
        let router = HomeRouter()
        let presenter = HomePresenter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        self.view = WeatherView(collectionDelegate: self,
                                collectionDataSource: self,
                                tabBarDelegate: router)
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
    }
    
    //MARK: HomeDisplayLogic
    func displayWeather(_ viewModel: Home.ViewModels.ViewModel) {
        homeViewModel = viewModel
        collectionView.reloadData()
        activityIndicator.stopAnimating()
        self.weatherView.generateGradient()
        
    }
    
    func displayError(message: String) {
        router?.showAlert(message: message)
        activityIndicator.stopAnimating()
        router?.showAlert(message: message)
    }
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationManager.startUpdatingLocation()
    }
    
    //MARK: Subviews
    var collectionView: UICollectionView!  {
        return (self.view as! WeatherView).collectionView
    }
    
    private var weatherView: WeatherView! {
        return (self.view as! WeatherView)
    }
    lazy var activityIndicator: UIActivityIndicatorView = {
        $0.hidesWhenStopped = true
        $0.stopAnimating()
        view.addSubview($0)
        $0.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-90)
        }
        return $0
    }(UIActivityIndicatorView())
    
}

//MARK: UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return homeViewModel.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        homeViewModel.numberOfItemsIn(section)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let section = Home.ViewModels.ViewModel.Section(rawValue: indexPath.section)
        
        switch section {
            
        case .daily:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyCell.description(), for: indexPath) as! DailyCell
            cell.viewModel = homeViewModel.dailySectionVM.itemViewModels[indexPath.item]
            return cell
            
        case .today:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayCell.description(), for: indexPath) as! TodayCell
            cell.viewModel = homeViewModel.todaySectionVM.itemViewModels[indexPath.item]
            return cell
            
        case .detail:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCell.description(), for: indexPath) as! DetailCell
            let vm = homeViewModel.detailSectionVM.itemViewModels[indexPath.item]
            cell.viewModel = vm
            return cell
            
        default:
            assert(false)
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
            
        case UICollectionView.elementKindSectionHeader :
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CurrentHeader.description(), for: indexPath) as? CurrentHeader else {
                fatalError("No appropriate view for supplementary view of \(kind) ad \(indexPath)")
            }
            let vm = homeViewModel.currentHourlySectionVM.headerViewModel
            header.viewModel = vm
            return header
            
        case UICollectionView.elementKindSectionFooter :
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HourlyFooter.description(), for: indexPath) as? HourlyFooter else {
                fatalError("No appropriate view for supplementary view of \(kind) at \(indexPath)")
            }
            let vm = homeViewModel.currentHourlySectionVM.footerViewModel
            footer.viewModel = vm
            return footer
            
        default:
            assert(false)
        }
    }
}


//MARK: UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    private var width: CGFloat {
        return collectionView.frame.width
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let section = indexPath.section
        let partialWidth = width * 0.9
        let height = Screen.height
        switch section {
        case 1:
            return CGSize(width: partialWidth , height: (height * 0.066))
        case 2:
            return CGSize(width: partialWidth, height: (height * 0.131))
        case 3:
            return CGSize(width: partialWidth, height: (height * 0.07))
        case 4:
            return CGSize(width: width, height: (height * 0.09))
        default:
            return .zero
        }
        
    }
    
    //header size
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        let headerSize = CGSize(width: width, height: CurrentHeader.defaultHeight)
        return section == 0 ? headerSize : .zero
    }
    //footer size
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
        let footerSize =  CGSize(width: width, height: HourlyFooter.defaultHeight)
        return section == 0 ? footerSize : .zero
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
}

extension HomeViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        locationManager.stopUpdatingLocation()
        getWeather(for: location)
        
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        router?.showAlert(message: "Error updating location \(error)")
    }
}

