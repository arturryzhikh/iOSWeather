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
    private var searchController: UISearchController!
    private var tableView: UITableView!
    private let activityIndicator: UIActivityIndicatorView = {
        $0.color = .white
        $0.hidesWhenStopped = true
        return $0
    }(UIActivityIndicatorView())
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
    // MARK: View lifecycle
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addBlur()
        setupSearchController(placeholder: "Search Cities")
        setupNavigationController(title: "Search Cities")
        setupTableView()
        activateConstraints()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    // MARK: Search Cities
    
    //@IBOutlet weak var nameTextField: UITextField!
    func searchCities(named: String) {
        interactor?.searchCities(named: named)
        activityIndicator.startAnimating()
    }
    //MARK: SearchDisplayLogic
    func displayCities(viewModel: Search.ViewModels.ViewModel) {
        self.viewModel = viewModel
        tableView.reloadData()
        activityIndicator.stopAnimating()
    }
    func displayError(message: String) {
        router?.showAlert(message: message)
        activityIndicator.stopAnimating()
    }
    
    //MARK: Initial setup
    private func setupTableView() {
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.register(PlaceCell.self,
                           forCellReuseIdentifier: PlaceCell.description())
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    private func setupSearchController(placeholder: String) {
        self.searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.tintColor = .white
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        searchController.definesPresentationContext = true
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = placeholder
        searchController.becomeFirstResponder()
    }
    private func setupNavigationController(title: String) {
        navigationItem.searchController = searchController
        navigationController?.hidesBarsOnSwipe = false
        navigationItem.title = title
        let activity = UIBarButtonItem(customView: activityIndicator)
        navigationItem.rightBarButtonItem = activity
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.barTintColor = .darkGray.withAlphaComponent(0.3)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
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
        guard !text.isEmpty else {
            return
        }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: PlaceCell.description(), for: indexPath) as! PlaceCell
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
        let viewModel = viewModel.itemViewModel(at: indexPath)
        router?.routeToHome(with: viewModel.name, and: Coord(lat: viewModel.latitude, lon: viewModel.longitude))
        
    }
    
    
}
