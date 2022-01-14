//
//  SectionRepresentable.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//
import Foundation

protocol FooterRepresentable {
    
    associatedtype FooterViewModel
    var footer: FooterViewModel { get }
    var numberOfItems: Int { get }
}

protocol HeaderRepresentable {
    
    associatedtype HeaderViewModel
    
    var header: HeaderViewModel { get }
    var numberOfItems: Int { get }
    
}

protocol ItemRepresentable {
    
    associatedtype ItemViewModel
    
    var items: [ItemViewModel] { get }
    
    var numberOfItems: Int { get }
    
}



