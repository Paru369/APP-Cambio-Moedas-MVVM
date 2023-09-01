//
//  MultiCurrencyFilterViewModel.swift
//  ExchangeRates
//
//  Created by Paulo Pinheiro on 8/31/23.
//

import SwiftUI


struct MultiCurrenciesFilterView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel = ViewModel()
    @State private var selections: [String] = []
    @State private var searchText = ""
   
    var searchesResult: [CurrencySymbolModel] {
        if searchText.isEmpty {
            return viewModel.currencySymbols
        } else {
            return viewModel.currencySymbols.filter {
                $0.symbol.contains(searchText.uppercased()) ||
                $0.fullName.uppercased().contains(searchText.uppercased())
            }
        }
    }
    
    var body: some View {
        NavigationView {
            listCurrencyView
        }
        .onAppear{
            viewModel.doFetchCurrencySymbols()
        }
    }
    
    private var listCurrencyView: some View {
        List(searchesResult, id: \.symbol) { item in
            
            Button {
                if selections.contains(item.symbol) {
                    selections.removeAll {$0 == item.symbol }
                } else {
                    selections.append(item.symbol)
                }
            } label: {
                HStack {
                    HStack {
                        Text(item.symbol)
                            .font(.system(size: 14, weight: .bold))
                        Text("-")
                            .font(.system(size: 14, weight: .semibold))
                        Text(item.fullName)
                            .font(.system(size: 14, weight: .semibold))
                        Spacer()
                    }
                    Image(systemName: "checkmark")
                        .opacity(selections.contains(item.symbol) ? 1.0 : 0.0)
                    Spacer()
                }
            }
            .foregroundColor(.primary)
        }
        .searchable(text: $searchText)
        .navigationTitle("Filter Currencies")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                dismiss()
                print("Select currency button")
            } label: {
                Text("OK")
                    .fontWeight(.bold
                    )
            }
        }
    }
    
}

struct MultiCurrenciesFilterView_Previews: PreviewProvider {
    static var previews: some View {
        MultiCurrenciesFilterView()
    }
}
