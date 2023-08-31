//
//  RatesFluctuationView.swift
//  ExchangeRates
//
//  Created by Paulo Pinheiro on 8/28/23.
//

import SwiftUI

// ---------------------- MOCK -------------------
struct Fluctuation: Identifiable, Equatable { //  Equatable
    let id = UUID()
    var symbol: String
    var change: Double
    var changePct: Double
    var endRate: Double
}

class RatesFluctuationVieWModel: ObservableObject {
    @Published var fluctuations: [Fluctuation] = [
        Fluctuation(symbol: "USD", change: 0.0008, changePct: 0.4175, endRate:8.18857),
        Fluctuation(symbol: "EUR", change: 0.8083, changePct: 0.1651, endRate: 0.181353),
        Fluctuation(symbol: "GBP", change: -0.0001, changePct: -0.0483, endRate: 0.158915)
    ]
}

struct RatesFluctuationView: View {
    
    @StateObject var viewModel = RatesFluctuationVieWModel()
    @State private var searchText  = ""
    @State private var isPresentedBaseCurrencyFilter = false
    
    
    
    var searchResult: [Fluctuation] {
        if searchText.isEmpty{
            return viewModel.fluctuations
        } else {
            return viewModel.fluctuations.filter {
                $0.symbol.contains(searchText.uppercased())  ||
                $0.change.formatter(decimalPlaces: 4).contains(searchText.uppercased()) ||
                $0.changePct.toPercentage().contains(searchText.uppercased()) ||
                $0.endRate.formatter(decimalPlaces: 2).contains(searchText.uppercased())
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                
                baseCurrencyPeriodFilterView
                
                ratesFluctuationListView
            }
            
            .searchable(text: $searchText)
            .navigationTitle("Exchange Currency")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    print("filtrar moedas")
                } label: {
                    Image(systemName: "slider.horizontal.3")
                }
                
            }
        }
    }
    
    private var baseCurrencyPeriodFilterView: some View {
        HStack(alignment: .center, spacing: 16) {
             Button {
                // print("Filter by currency")
                 isPresentedBaseCurrencyFilter.toggle()
             } label: {
                 Text("BRL")
                     .font(.system(size: 14, weight: .bold))
                     .padding(.init(top:4, leading: 8, bottom: 4, trailing: 8))
                     .foregroundColor(.white)
                     .overlay{
                         RoundedRectangle(cornerRadius: 8)
                             .stroke(.white, lineWidth: 8)
                     }
             }
             .fullScreenCover(isPresented: $isPresentedBaseCurrencyFilter, content: { BaseCurrencyFilterView() })
             .background(Color(UIColor.lightGray))
             .cornerRadius(8)
             
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
        .padding(.top, 8)
        .padding(.bottom, 16)
     }
    
    private var ratesFluctuationListView: some View {
        List(searchResult) { fluctuation in
            NavigationLink(destination: RateFluctuationDetailView(baseCurrency: "BRL", rateFluctuation: fluctuation)) {
                VStack {
                    HStack(alignment: .center, spacing: 8) {
                        Text("\(fluctuation.symbol) / BRL")
                            .font(.system(size: 14, weight: .medium))
                        Text("\(fluctuation.endRate.formatter(decimalPlaces: 2))")
                            .font(.system(size: 14, weight: .bold))
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        Text("\(fluctuation.change.formatter(decimalPlaces: 4, with: true))")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(fluctuation.change.color())
                        Text("\(fluctuation.changePct.toPercentage())")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(fluctuation.changePct.color())
                    }
                    Divider()
                        .padding(.leading, -20).padding(.trailing, -40)
                    }
                }
                .listRowSeparator(.hidden)
                .listRowBackground(Color.white)
            }
            .listStyle(.plain)
        }
}

struct RatesFluctuationView_Previews: PreviewProvider {
    static var previews: some View {
        RatesFluctuationView()
    }
}
