//
//  SearchViewController.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 17.01.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import SnapKit
import CoreLocation
protocol SearchDisplayLogic: AnyObject {
    func displayCities(viewModel: Search.ViewModels.ViewModel)
    func displayError(message: String)
}

class SearchViewController: UIViewController, SearchDisplayLogic {
    
    var interactor: SearchBusinessLogic?
    var router: (NSObjectProtocol & SearchRoutingLogic & SearchDataPassing)?
    
    private var viewModel = Search.ViewModels.ViewModel()
    
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
        let interactor = SearchInteractor()
        let presenter = SearchPresenter()
        let router = SearchRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    //
    //  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //    if let scene = segue.identifier {
    //      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
    //      if let router = router, router.responds(to: selector) {
    //        router.perform(selector, with: segue)
    //      }
    //    }
    //  }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addBlur()
        setupSearchController(placeholder: "Search Cities")
        setupNavigationController(title: "Search Cities")
        setupTableView()
        activateConstraints()
        
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    private func searchCities(named: String) {
//        let request = Search.Requests.Forecast(cityName: named)
        let req = Search.Requests.CitiesRequest(cityName: named)
        interactor?.searchCities(request: req)
    }
    
    func displayCities(viewModel: Search.ViewModels.ViewModel) {
        self.viewModel = viewModel
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
            
        }
    }
    func displayError(message: String) {
        
    }
    
    
    //MARK: Subviews
    private let searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        return sc
    }()
    private let activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView()
        ai.hidesWhenStopped = true
        return ai
    }()
    private let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.backgroundColor = .clear
        tv.showsVerticalScrollIndicator = false
        return tv
    }()
    
    //MARK: Initial setup
    private func setupTableView() {
        tableView.register(CityCell.self,
                           forCellReuseIdentifier: CityCell.description())
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    private func setupSearchController(placeholder: String) {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        searchController.definesPresentationContext = true
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = placeholder
    }
    private func setupNavigationController(title: String) {
        navigationItem.searchController = searchController
        navigationController?.hidesBarsOnSwipe = false
        navigationItem.title = title
        let activity = UIBarButtonItem(customView: activityIndicator)
        navigationItem.rightBarButtonItem = activity
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.barTintColor = .darkGray.withAlphaComponent(0.3)
        
    }
    //MARK: Constraints
    private func activateConstraints() {
        view.addMultipleSubviews(
            tableView
        )
        //table view
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.bottom.trailing.equalToSuperview()
        }

        
    }
    
}
//MARK: UISearchResultsUpdating delegate

extension SearchViewController: UISearchResultsUpdating  {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        activityIndicator.startAnimating()
        searchCities(named: text)
        
    }
    
}

//MARK: UITableViewDataSource
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityCell.description(), for: indexPath) as! CityCell
        cell.viewModel = viewModel.itemViewModels[indexPath.row]
        return cell
    }
    
    
    //MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }

        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }

        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            cell.layoutIfNeeded()
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
}
