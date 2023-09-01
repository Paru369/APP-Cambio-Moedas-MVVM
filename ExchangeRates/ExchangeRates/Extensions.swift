//
//  Extensions.swift
//  ExchangeRates
//
//  Created by Paulo Pinheiro on 8/29/23.
//

import Foundation
import SwiftUI
extension Double {
    
    func formatter(decimalPlaces: Int, with changeSymbol: Bool = false) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.roundingMode = .halfUp
        numberFormatter.minimumFractionDigits = (decimalPlaces > 2) ? decimalPlaces : 2
        numberFormatter.maximumFractionDigits = (decimalPlaces > 2) ? decimalPlaces : 2
        numberFormatter.locale = Locale(identifier: "pt_BR")
        
        guard let value = numberFormatter.string(from: NSNumber(value: self)) else { return String(self)}
        
        if changeSymbol {
            
            if self.sign == .minus {
                return  " \(value)"
            } else {
                return  " +\(value)"
            }
        }
            
        return value.replacingOccurrences(of: "-", with: "")

    }
    
    func toPercentage(with changeSymbol: Bool = false) -> String {
        let value = formatter(decimalPlaces: 2)
        
        if changeSymbol {
            if self.sign == .minus{
                return "\u{2193} \(value)%"
            } else {
                return "\u{2191} \(value)%"
            }
        }
        
        return "\(value)%"
    }
    
    func color() -> Color {
        if self.sign == .minus {
            return .red
        } else {
            return .green
        }
    }
        
}

extension String {
    func toDate(dateFormat: String = "yyyy-MM-DD") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.date(from: self) ?? Date()
    }
}

extension Date {
    init(from component: Calendar.Component, value: Int) {
        self = Calendar.current.date(byAdding: component, value: -value, to: Date()) ?? Date()
    }
    
    func formatter(to dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR_POSIX")
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
    
    func toString(dateFormat: String = "yyy-MM-dd") -> String {
        return formatter(to:dateFormat)
    }
}

extension UINavigationController {
    open override func viewWillLayoutSubviews() {
        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

