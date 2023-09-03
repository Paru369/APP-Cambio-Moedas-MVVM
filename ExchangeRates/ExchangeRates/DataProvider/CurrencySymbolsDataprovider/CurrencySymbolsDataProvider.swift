//
//  CurrencySymbolsDataProvider.swift
//  ExchangeRates
//
//  Created by Paulo Pinheiro on 8/28/23.
//

import Foundation


protocol CurrencySymbolsDataProviderDelegate: DataProviderManagerDelegate {
    func success(model: [CurrencySymbolModel])
}


class CurrencySymbolsDataProvider: DataProviderManager<CurrencySymbolsDataProviderDelegate, [CurrencySymbolModel]> {
    
    private let currencyStore: CurrencyStore
    
    init(currencyStore: CurrencyStore = CurrencyStore()) {
        self.currencyStore = currencyStore
    }
    
    func fetchSymbols() {
        Task.init {
            do {
                let object = try await currencyStore.fetchSymbols()
                delegate?.success(model: object.map({ (symbol, fullName) -> CurrencySymbolModel in
                    return CurrencySymbolModel(symbol: symbol, fullName: fullName)
                }))
            } catch {
                delegate?.errorData(delegate, error: error)
                print("deu Ruim")
            }
        }
    }
}
