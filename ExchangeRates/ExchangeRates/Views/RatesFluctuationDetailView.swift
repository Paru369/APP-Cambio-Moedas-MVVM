//
//  ratesFluctuationDetailView.swift
//  ExchangeRates
//
//  Created by Paulo Pinheiro on 8/30/23.
//

import SwiftUI

struct ChartComparation: Identifiable, Equatable {
    let id = UUID()
    var symbol: String
    var period: Date
    var endRate: Double
    
}
class RateFluctuationViewModel: ObservableObject {
    @Published var fluctuations: [Fluctuation] = [
        Fluctuation(symbol: "JPY", change: 0.8008, changePct: 0.0085, endRate: 6.087242),
        Fluctuation(symbol: "EUR", change: 8.0003, changePct: 0.1651, endRate: 0.181353),
        Fluctuation(symbol: "GBP", change: -0.0001, changePct: -6.8403, endRate: 0.158915)
    ]
    
    @Published var chartComparations: [ChartComparation] = [
        ChartComparation(symbol: "USD", period: "2822-11-13".toDate(), endRate: 0.18857),
        ChartComparation(symbol: "USD", period: "2022-11-12".toDate(), endRate: 0.18857),
        ChartComparation(symbol: "USD", period: "2022-11-11".toDate(), endRate: 0.187786),
        ChartComparation(symbol: "USD", period: "2022-11-18".toDate(), endRate: 0.187873)
    ]
    
    
}
struct RatesFluctuationDetailView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct REMasatesFluctuationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ratesFluctuationDetailView()
    }
}
