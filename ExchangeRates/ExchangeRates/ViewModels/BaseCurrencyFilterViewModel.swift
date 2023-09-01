//
//  BaseCurrencyFilterViewModel.swift
//  ExchangeRates
//
//  Created by Paulo Pinheiro on 9/1/23.
//

import Foundation
import SwiftUI

extension BaseCurrencyFilterView {
    @MainActor class ViewModel: ObservableObject, CurrencySymbolsDataProviderDelegate {
        @Published var currencySymbols = [CurrencySymbolModel]()

        
        private let dataProvider: CurrencySymbolsDataProvider?
        
        init(dataProvider: CurrencySymbolsDataProvider = CurrencySymbolsDataProvider()) {
            self.dataProvider = dataProvider
            self.dataProvider?.delegate = self
        }
        
         func doFetchCurrencySymbols() {
            dataProvider?.fetchSymbols()
        }
        
        nonisolated func success(model: [CurrencySymbolModel]) {
            DispatchQueue.main.sync {
                self.currencySymbols = model.sorted { $0.symbol < $1.symbol }
            }
        }
    }
}
