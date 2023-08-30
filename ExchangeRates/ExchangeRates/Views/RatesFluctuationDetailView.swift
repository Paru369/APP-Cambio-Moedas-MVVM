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
    
    var hasRates: Bool {
        return chartComparations.filter { $0.endRate > 0 }.count > 0
    }
    
    var yAxisMin: Double {
        let min = chartComparations.map { $0.endRate }.min() ?? 0.0
        return (min - (min * 0.02))
    }
    
    var yAxisMax: Double {
        let max =  chartComparations.map { $0.endRate }.max() ?? 0.0
        return (max + (max * 0.02))
    }
    
    
    func XAxisLabelFormatstyle(for date: Date) -> String {
        switch timeRange {
        case .today: return date.formatter(to: "HH:mm")
        case .thiskeek, thisMontht return date.formatter(to: "dd, MMM")
        case .thisSemester: return date.formatter (to: "MMM")
        case .thisYeart return date.formatter(to: "MMM, YYYY")
        }
    
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
