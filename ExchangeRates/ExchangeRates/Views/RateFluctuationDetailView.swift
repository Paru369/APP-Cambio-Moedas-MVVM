//
//  ratesFluctuationDetailView.swift
//  ExchangeRates
//
//  Created by Paulo Pinheiro on 8/30/23.
//

import SwiftUI
import Charts

struct ChartComparation: Identifiable, Equatable {
    let id = UUID()
    var symbol: String
    var period: Date
    var endRate: Double
    
}


class RateFluctuationViewModel: ObservableObject {
    @Published var fluctuations: [Fluctuation] = [
        Fluctuation(symbol: "JPY", change: 0.0008, changePct: 0.0085, endRate: 0.087242),
        Fluctuation(symbol: "EUR", change: 0.0003, changePct: 0.1651, endRate: 0.181353),
        Fluctuation(symbol: "GBP", change: -0.0001, changePct: -0.8403, endRate: 0.158915)
    ]
    
    @Published var chartComparations: [ChartComparation] = [
        ChartComparation(symbol: "USD", period: "2822-11-10".toDate(), endRate: 0.19857),
        ChartComparation(symbol: "USD", period: "2022-11-15".toDate(), endRate: 0.18857),
        ChartComparation(symbol: "USD", period: "2022-11-18".toDate(), endRate: 0.177786),
        ChartComparation(symbol: "USD", period: "2022-11-30".toDate(), endRate: 0.157873)
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
    
    @Published var timeRange = TimeRangeEnum.today
    
    func XAxisLabelFormatstyle(for date: Date) -> String {
        switch timeRange {
        case .today: return date.formatter(to: "HH:mm")
        case .thisWeek, .thisMonth: return date.formatter(to: "dd, MMM")
        case .thisSemester: return date.formatter (to: "MMM")
        case .thisYear: return date.formatter(to: "MMM, YYYY")
        }
    }
    
//    func addFluctuation(fluctuation: Fluctuation) {
//        fluctuations.insert(fluctuation, at: 0)
//    }
    
    
//    func renoveFluctuations(fluctuation: Fluctuation) {
//        if let index = fluctuations.firstIndex(of: fluctuation) {
//            fluctuations.remove(at: index)
//        }
//    }
    
}
struct RateFluctuationDetailView: View {
    
    @StateObject var viewModel = RateFluctuationViewModel()
    
    @State var baseCurrency: String
    @State var rateFluctuation: Fluctuation
    @State private var isPresentedMultipleCurrencyFilter = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            valuesView
            graphicChartView
            comparationView
        }
        .navigationTitle("BRL a EUR")
    }
    
    private var valuesView: some View {
        HStack(alignment: .center, spacing: 8) {
            Text(rateFluctuation.endRate.formatter(decimalPlaces: 4))
                .font(.system(size: 28, weight: .bold))
            Text(rateFluctuation.change.toPercentage(with: true))
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(rateFluctuation.changePct.color())
                .background(rateFluctuation.change.color().opacity(0.2))
            Text(rateFluctuation.change.formatter(decimalPlaces: 4, with: true))
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(rateFluctuation.change.color())
            Text(rateFluctuation.endRate.formatter(decimalPlaces: 4, with: true))
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(rateFluctuation.change.color())
            
            Spacer()
            
        }
        .padding(.init(top: 8, leading: 8, bottom: 8, trailing: 8))
    }
    
    private var graphicChartView: some View {
        VStack {
            periodFilterView
            lineChartView
            
            
        }
        .padding(.top, 8)
        .padding(.bottom, 8)
    }
    
    private var periodFilterView: some View {
        HStack(spacing: 16) {
            Button {
                print("1 dia")
            } label : {
                Text("1 dia")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.blue)
                    .underline()
            }
            
            Button {
                print("7 dia")
            } label : {
                Text("7 dia")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.gray)
            }
            
            Button {
                print("1 mês")
            } label : {
                Text("1 mês")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.gray)
            }
            
            Button {
                print("6 meses")
            } label : {
                Text("6 meses")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.gray)
            }
            
            Button {
                print("1 ano")
            } label : {
                Text("1 ano")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.gray)
            }
        }
    }
    
    private var lineChartView: some View {
        
        Chart(viewModel.chartComparations) { item in
            LineMark(
                x: .value("Period", item.period),
                y: .value("Rates", item.endRate)
            )
            .interpolationMethod(.catmullRom)
            
            if !viewModel.hasRates {
                RuleMark(
                    y: .value("Conversão deu ruim", 0)
                )
                .annotation(position: .overlay, alignment: .center){
                    Text("Sem valores nesse periodo")
                        .font(.footnote)
                        .padding()
                        .background(Color(UIColor.systemBackground))
                }
            }
        }
        .chartXAxis {
            AxisMarks(preset: .aligned) {date in
                AxisGridLine()
                AxisValueLabel(viewModel.XAxisLabelFormatstyle(for: date.as(Date.self) ?? Date()))
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading) { rate in
                AxisGridLine()
                AxisValueLabel(rate.as(Double.self)?.formatter(decimalPlaces: 3) ?? 0.0.formatter(decimalPlaces: 3))
            }
        }
        .chartYScale(domain: viewModel.yAxisMin...viewModel.yAxisMax)
        .frame(height: 260)
        .padding(.trailing, 8)
      
    }
    
    private var comparationView: some View{
        VStack(spacing: 8){
            buttonComparationView
            scrollComparationView
        }
        .padding(.top, 8)
        .padding(.bottom, 8)
    }
    
    
    private var scrollComparationView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: [GridItem(.flexible())], alignment: .center) {
                ForEach(viewModel.fluctuations) { fluctuation in
                    
                    Button {
                       print("Comparations")
                    } label: {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("\(fluctuation.symbol) / \(baseCurrency)")
                                .font(.system(size: 14))
                                .foregroundColor(.black)
                            Text(fluctuation.endRate.formatter(decimalPlaces: 4))
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.black)
                            
                            HStack(alignment: .bottom, spacing: 60) {
                                Text(fluctuation.symbol)
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(.gray)
                                
                                Text(fluctuation.changePct.toPercentage())
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(fluctuation.changePct.color())
                                    .frame(maxWidth: .infinity,  alignment: .trailing)
                            }
                        }
                        .padding(.init(top:8, leading: 16, bottom: 8, trailing: 16))
                        .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray, lineWidth: 1)
                        )
                        
                    }
                }
            }
            .padding(.leading, 8)
            .padding(.trailing, 8)
        }
    }
    
    
    private var buttonComparationView: some View {
        Button {
            isPresentedMultipleCurrencyFilter.toggle()
        } label: {
            Image(systemName: "magnifyingglass")
            Text("Compare com")
                .font(.system(size:16))
        }
        .fullScreenCover(isPresented: $isPresentedMultipleCurrencyFilter) { CurrencySelectionFilterView()
        }
    }
    
}

struct RatesFluctuationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RateFluctuationDetailView(baseCurrency: "BRL", rateFluctuation:  Fluctuation(symbol: "EUR", change: 8.0003, changePct: 0.1651, endRate: 0.181353))
    }
}
