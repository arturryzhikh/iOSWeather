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
    func displayWeather(viewModel: Home.ViewModels.ViewModel)
    func displayError(message: String)
}

final class HomeViewController: UIViewController, HomeDisplayLogic {
    
    
    //MARK: Other Properties
    private let locationManager: CLLocationManager = CLLocationManager()
    private let viewModel = Home.ViewModels.ViewModel()
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
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }

    //MARK: HomeDisplayLogic
    
    func displayWeather(viewModel: Home.ViewModels.ViewModel) {
        self.viewModel.currentHourlySectionVM = viewModel.currentHourlySectionVM
        self.viewModel.dailySectionVM = viewModel.dailySectionVM
        self.viewModel.todaySectionVM = viewModel.todaySectionVM
        self.viewModel.detailSectionVM = viewModel.detailSectionVM
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.collectionView.reloadData()
            self.activityIndicator.stopAnimating()
            
        }
    }
    
    func displayError(message: String) {
        router?.showAlert(message: message)
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.activityIndicator.stopAnimating()
        }
        
    }
    //MARK: Subviews
    
    //MARK: View Life Cycle
    override func loadView() {
        view = WeatherView()
        
    }
    var collectionView: UICollectionView!  {
        return (self.view as! WeatherView).collectionView
    }
    
    private var weatherView: UIView! {
        return self.view as! WeatherView
    }
    private lazy var activityIndicator: UIActivityIndicatorView = {
        $0.hidesWhenStopped = true
        $0.stopAnimating()
        view.addSubview($0)
        $0.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-90)
        }
        return $0
    }(UIActivityIndicatorView())
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
}

//MARK: UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsIn(section)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let section = Home.ViewModels.ViewModel.Section(rawValue: indexPath.section)
        
        switch section {
        
        case .daily:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyCell.description(), for: indexPath) as! DailyCell
            cell.viewModel = viewModel.dailySectionVM.itemViewModels[indexPath.item]
            return cell
            
        case .today:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayCell.description(), for: indexPath) as! TodayCell
            cell.viewModel = viewModel.todaySectionVM.itemViewModels[indexPath.item]
            return cell
            
        case .detail:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCell.description(), for: indexPath) as! DetailCell
            let vm = viewModel.detailSectionVM.itemViewModels[indexPath.item]
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
            let vm = viewModel.currentHourlySectionVM.headerViewModel
            header.viewModel = vm
            return header
            
        case UICollectionView.elementKindSectionFooter :
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HourlyFooter.description(), for: indexPath) as? HourlyFooter else {
                fatalError("No appropriate view for supplementary view of \(kind) at \(indexPath)")
            }
            let vm = viewModel.currentHourlySectionVM.footerViewModel
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
        let request = Home.Requests.Request(coordinate: (lat: location.coordinate.latitude,
                                                        lon: location.coordinate.longitude))
        
        interactor?.getForecast(request)
        activityIndicator.startAnimating()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}


