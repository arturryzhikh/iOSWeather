//
//  ViewModelRepresentable.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//


protocol ViewModelRepresentable {
    
    associatedtype ViewModel: ModelInstantiable
    
    var viewModel: ViewModel? { get }
    
    func populateSubviews(with viewModel: ViewModel)
    
}
