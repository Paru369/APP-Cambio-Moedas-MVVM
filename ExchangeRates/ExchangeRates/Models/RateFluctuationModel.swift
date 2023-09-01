//
//  RateFluctuationModel.swift
//  ExchangeRates
//
//  Created by Paulo Pinheiro on 9/1/23.
//

import Foundation


struct RateFluctuationModel: Identifiable, Equatable { //
    let id = UUID()
    var symbol: String
    var change: Double
    var changePct: Double
    var endRate: Double
}
