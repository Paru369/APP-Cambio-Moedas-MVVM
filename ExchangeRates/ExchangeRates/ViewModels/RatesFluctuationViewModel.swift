//
//  RatesFluctuationViewModel.swift
//  ExchangeRates
//
//  Created by Paulo Pinheiro on 9/1/23.
//

import Foundation
import SwiftUI


extension RatesFluctuationView {
    @MainActor class ViewModel: ObservableObject {
        @Published var ratesFluctuations =  [RateFluctuationModel]()
        
        private let dataProvider: RatesFluctuationDataProvider?
        
        
        init(dataProvider: RatesFluctuationDataProvider? = RatesFluctuationDataProvider()) {
            self.dataProvider = dataProvider
            self.dataProvider.self
        }
    }
}
