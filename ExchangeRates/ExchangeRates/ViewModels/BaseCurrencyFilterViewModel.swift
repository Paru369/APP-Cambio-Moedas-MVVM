//
//  BaseCurrencyFilterViewModel.swift
//  ExchangeRates
//
//  Created by Paulo Pinheiro on 9/1/23.
//

import Foundation
import SwiftUI

extension BaseCurrencyFilterView {
    @MainActor class ViewModel: ObservableObject {
        @Published var currencySymbols = [CurrencySymbolModel]()

    }
}
