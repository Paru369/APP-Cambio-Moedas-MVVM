//
//  RateFluctuationDetailViewModel.swift
//  ExchangeRates
//
//  Created by Paulo Pinheiro on 9/2/23.
//

import Foundation
import SwiftUI

extension RateFluctuationDetailView {
    @MainActor class ViewModel: ObservableObject, RatesFluctuationDataProviderDelegate, RatesHistoricalDataProviderDelegate {
        @Published var RateFluctuation = [RateFluctuationModel]()
        @Published var rateHistorical = [RateHistoricalModel]()
        @Published var timeRange = TimeRangeEnum.today
        
        private var fluctuationDataProvider: RatesFluctuationDataProvider?
        private var historicalDataProvider: RatesHistoricalDataProvider?
        
        init(fluctuationDataProvider: RatesFluctuationDataProvider = RatesFluctuationDataProvider(),
             historicalDataProvider: RatesHistoricalDataProvider = RatesHistoricalDataProvider()) {
            
            self.fluctuationDataProvider = fluctuationDataProvider
            self.historicalDataProvider = historicalDataProvider
            
            self.fluctuationDataProvider?.delegate = self
            self.historicalDataProvider?.delegate = self
        }
    }
}
