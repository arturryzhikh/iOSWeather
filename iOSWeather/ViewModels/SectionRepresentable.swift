//
//  SectionRepresentable.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//
import Foundation

protocol FooterRepresentable {
    
    associatedtype FooterViewModel: ModelInstantiable
    var footer: FooterViewModel { get }
    var numberOfItems: Int { get }
}

protocol HeaderRepresentable {
    
    associatedtype HeaderViewModel: ModelInstantiable
    
    var header: HeaderViewModel { get }
    var numberOfItems: Int { get }
    
}

protocol ItemRepresentable {
    
    associatedtype ItemViewModel: ModelInstantiable
    
    var items: [ItemViewModel] { get }
    
    var numberOfItems: Int { get }
    
}



