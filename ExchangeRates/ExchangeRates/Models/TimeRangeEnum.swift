//
//  TimeRangeEnum.swift
//  ExchangeRates
//
//  Created by Paulo Pinheiro on 8/30/23.
//

import Foundation


enum TimeRangeEnum {
    case today
    case thisWeek
    case thisMonth
    case thisSemester
    case thisYear
    
    var date: Date {
        switch self {
        case .today return Date(from: )
        case .thisWeek
        case .thisMonth
        case .thisSemester
        case .thisYear
            
        }
    }
}
