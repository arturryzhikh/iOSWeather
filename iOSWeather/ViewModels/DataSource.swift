//
//  DataSource.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//

import Foundation


enum Section: Int, CaseIterable {
    case currentHourly, daily, today, detail, link
 }


final class DataSource: NSObject, ApiConnectable, StaticCollectionRepresentable {
    
    var model: Forecast? {
        didSet {
            if let model = model {
                print(model)
                generateSectionViewModels(model: model)
                reloadClosure?()
            }
        }
    }
    
    
    //MARK: Section View Models
    var currentHourlySectionVM: CurrentHourlySectionVM?
    var dailySectionVM: DailySectionVM?
    var todaySectionVM: TodaySectionVM?
    var detailSectionVM: DetailSectionVM?
    var linkSectionVM: LinkSectionVM?
    
    //MARK: Life Cycle
    init(apiService: APIService = WeatherService.shared) {
        self.apiService = apiService
        
    }
    //MARK: Properties
    
    var sections: [Int] = [
        Section.currentHourly.rawValue,
        Section.daily.rawValue,
        Section.today.rawValue,
        Section.detail.rawValue,
        Section.link.rawValue
    ]
    
    var reloadClosure: (()->Void)?
    
    var apiService: APIService!
    
    var isFetching: Bool = false
    
    var numberOfSections: Int {
        return sections.count
    }
    
    
    func numberOfItemsIn(_ section: Int) -> Int {
        
        let section = Section(rawValue: section)
        switch section {
            
        case .currentHourly:
            return currentHourlySectionVM?.numberOfItems ?? 0
            
        case .daily:
            return dailySectionVM?.numberOfItems ?? 0
            
        case .today:
            return todaySectionVM?.numberOfItems ?? 0
            
        case .detail:
            return detailSectionVM?.numberOfItems ?? 0
        case .link:
            return linkSectionVM?.numberOfItems ?? 0
            
        default:
            return 0
        }
    }
    func generateSectionViewModels(model: Forecast) {
        currentHourlySectionVM = CurrentHourlySectionVM(model: model)
        dailySectionVM = DailySectionVM(model: model)
        todaySectionVM = TodaySectionVM(model: model)
        detailSectionVM = DetailSectionVM(model: model)
        linkSectionVM = LinkSectionVM(model: model)
        
    }
    
    
    
    
}

//MARK: Fetch Wather

extension DataSource {
    
    func getWeatherWith(_ request: WeatherRequest) {
        
        isFetching = true
        
        apiService.request(request) { (result) in
            
            switch result {
            case .failure(let error):
                print(error)
            case .success(let weather):
                self.model = weather
                
            }
        }
    }
    
}

