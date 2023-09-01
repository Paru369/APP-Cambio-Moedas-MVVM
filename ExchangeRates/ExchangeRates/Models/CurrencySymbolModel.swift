//
//  CurrencySymbolModel.swift
//  ExchangeRates
//
//  Created by Paulo Pinheiro on 9/1/23.
//

import Foundation

struct CurrencySymbolModel: Identifiable, Equatable {
    let id = UUID()
    var symbol: String
    var fullName: String
}
