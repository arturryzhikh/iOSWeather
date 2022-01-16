//
//  CollectionViewModel.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 15.01.2022.
//
 import Foundation

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
        return sections[section].cellViewModels.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> Section.CellViewModel?  {
        return sections[indexPath.section].cellViewModels[indexPath.row]
    }
    
 }






