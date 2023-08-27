//
//  RatesFluctuationObejct.swift
//  ExchangeRates
//
//  Created by Paulo Pinheiro on 8/27/23.
//

import Foundation

typealias RatesFluctuationObject = [String: FluctuationObject]

struct FluctuationObject: Codable {
    let change: Double
    let changePct: Double
    let endRate: Double

    enum CodingKeys: String, CodingKey {
        case change
        case changePct = "change_pct"
        case endRate = "end_rate"
    }
}

