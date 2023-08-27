//
//  RatesApi.swift
//  ExchangeRates
//
//  Created by Paulo Pinheiro on 8/27/23.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
}

struct RatesApis {
    static let baseUrl = " https://api.apilayer.com/exchangerates_data"
    static let apiKey = "YJxBXFq86WfWLydsSJrZTvm2LEgE0RYL"
    static let fluctuation = " /fluctuation"
    static let symbols = " /symbols"
    static let timeseries = "/timeseries"
}
