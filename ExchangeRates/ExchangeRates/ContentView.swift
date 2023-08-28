//
//  ContentView.swift
//  ExchangeRates
//
//  Created by Paulo Pinheiro on 8/27/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button {
                doFetchData()
            } label: {
                Image(systemName: "network")
            }
        }
        .padding()
    }
    
    private func doFetchData() {
    let rateFluctuationDataProvider = RatesFluctuationDataProvider()
    
    rateFluctuationDataProvider.delegate = self
    rateFluctuationDataProvider.fetchFluctuation(by:"BRL",from:
    ["USD", "EUR"], startDate: "2023-08-26", endDate: "2023-08-27")
    
    let rateSymbolDataProvider = CurrencySymbolsDataProvider()
    rateSymbolDataProvider.delegate = self
    rateSymbolDataProvider.fetchSymbols()
    
    let rateHistoricalDataProvider = RatesHistoricalDataProvider()
    rateHistoricalDataProvider.delegate = self
    rateHistoricalDataProvider.fetchTimeseries(by:"BRL",from:"USD",
    startDate: "2023-08-26", endDate: "2023-08-27")
    }
}

extension ContentView: RatesFluctuationDataProviderDelegate {
    func success (model: RatesFluctuationObject) {
        print ("RateFluctuationModel: \(model)\nin")
    }
}

extension ContentView: CurrencySymbolsDataProviderDelegate {
    func success (model: CurrencySymbolObject) {
        print ("RateSymbolDataProviderDelegate: \(model)\n\n")
    }
}

extension ContentView: RatesHistoricalDataProviderDelegate {
    func success (model: RatesHistoricalObject) {
        print ("RateHistoricalModel: \(model)\n\n")
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
