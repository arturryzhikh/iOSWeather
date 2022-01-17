//
//  SectionRepresentable.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//
import Foundation

public protocol SectionWithItemsViewModel {
    associatedtype CellViewModel
    var itemViewModels: [CellViewModel] { get }
    var count: Int { get }
}
extension SectionWithItemsViewModel {
    var count: Int {
        return itemViewModels.count
    }
}


public protocol SectionWithHeaderViewModel {
    associatedtype headerViewModel
    var headerViewModel: headerViewModel  { get }
    var count: Int {  get }
}


public protocol SectionWithFooterViewModel {
    associatedtype FooterViewModel
    var footerViewModel: FooterViewModel { get  }
    var count: Int { get }
}
