//
//  String+emptySting.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 16.01.2022.
//

import Foundation
extension String {
    static var emptyString: String {
        return ""
    }
    var isValid: Bool {
        return self.first != " " && self.last != " "
    }
}
