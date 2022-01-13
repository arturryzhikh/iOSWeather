//
//  LinkSectionVM.swift
//  iOSWeather
//
//  Created by Artur Ryzhikh on 13.01.2022.
//
import Foundation



struct LinkSectionVM: ItemRepresentable, ModelInstantiable {
    
    var numberOfItems: Int {
        return items.count
    }
    var model: WeatherResponse
    
    init(model: WeatherResponse) {
        self.model = model
    }
    var items: [LinkCellVM] {
        var items: [LinkCellVM] = []
        items.append(LinkCellVM(model: model))
        return items
    }
    
}

struct LinkCellVM: ModelInstantiable {
    
    let model: WeatherResponse
    
    var linkAttributedString: NSMutableAttributedString {
        guard let timezone = model.timezone else {
            return NSMutableAttributedString(string: "")
        }
        let location = timezone.components(separatedBy: "/")[1].replacingOccurrences(of: "_", with: " ")
        let attrSting = NSMutableAttributedString(string: "Weather for \(location). Website")
//        attrSting.addAttribute(.link, value: "https://openweathermap.org", range: NSRange("Website")!)
        return attrSting
    }
    
   
    init(model: WeatherResponse) {
        self.model = model
        
    }
   
}

//    override func viewDidLoad() {
//        let attributedString = NSMutableAttributedString(string: "Want to learn iOS? You should visit the best source of free iOS tutorials!")
//        attributedString.addAttribute(.link, value: "https://www.hackingwithswift.com", range: NSRange(location: 19, length: 55))
//
//        textView.attributedText = attributedString
//    }
//
//    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
//        UIApplication.shared.open(URL)
//        return false
//    }

