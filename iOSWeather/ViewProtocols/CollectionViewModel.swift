//
//  CollectionViewModel.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 15.01.2022.
//
 import Foundation
//struct ViewModel {
//    enum Section: Int, CaseIterable {
//        case currentHourly,
//             daily,
//             today,
//             detail,
//             link
//    }
//
//    init(currentHourlySectionVM: CurrentHourlySectionViewModel = CurrentHourlySectionViewModel.init(),
//         dailySectionVM: DailySectionViewModel = DailySectionViewModel(),
//         todaySectionVM: TodaySectionViewModel = .init(),
//         detailSectionVM: DetailSectionViewModel = .init(),
//         linkSectionVM: LinkSectionViewModel = .init()) {
//        self.currentHourlySectionVM = currentHourlySectionVM
//        self.dailySectionVM = dailySectionVM
//        self.todaySectionVM = todaySectionVM
//        self.detailSectionVM = detailSectionVM
//        self.linkSectionVM = linkSectionVM
//    }
//
//    //MARK: Section View Models
//    var currentHourlySectionVM: CurrentHourlySectionViewModel
//    var dailySectionVM: DailySectionViewModel
//    var todaySectionVM: TodaySectionViewModel
//    var detailSectionVM: DetailSectionViewModel
//    var linkSectionVM: LinkSectionViewModel
//
//    //MARK: Properties
//
//    var sections: [Int] = [
//        Section.currentHourly.rawValue,
//        Section.daily.rawValue,
//        Section.today.rawValue,
//        Section.detail.rawValue,
//        Section.link.rawValue
//    ]
//
//    var isFetching: Bool = false
//
//    var numberOfSections: Int {
//        return sections.count
//    }
//    func numberOfItemsIn(_ section: Int) -> Int {
//
//        switch Section(rawValue: section) {
//
//        case .currentHourly:
//            return currentHourlySectionVM.count
//
//        case .daily:
//            return dailySectionVM.count
//
//        case .today:
//            return todaySectionVM.count
//
//        case .detail:
//            return detailSectionVM.count
//        case .link:
//            return linkSectionVM.count
//
//        default:
//            return 0
//        }
//    }
//
//}
public protocol CollectionViewModel: AnyObject {
    
    associatedtype Section: SectionWithItemsViewModel
    var sections: [Section] { get }
    var numberOfSections: Int { get }
    func numberOfRowsIn(section: Int) -> Int
    func cellViewModel(at indexPath: IndexPath) -> Section.CellViewModel?
 
}
extension CollectionViewModel {
    
    var numberOfSections: Int {
        return sections.count
    }
   
    func numberOfRowsIn(section: Int) -> Int {
        return sections[section].itemViewModels.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> Section.CellViewModel?  {
        return sections[indexPath.section].itemViewModels[indexPath.row]
    }
    
 }






