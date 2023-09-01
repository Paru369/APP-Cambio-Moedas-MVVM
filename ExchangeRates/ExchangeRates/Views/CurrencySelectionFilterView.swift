//
//  CurrencySelectionFilterView.swift
//  ExchangeRates
//
//  Created by Paulo Pinheiro on 8/31/23.
//

import SwiftUI

class CurrencySelectionFilterViewModel: ObservableObject {
@Published var symbols: [Symbol] = [
    Symbol(symbol:"BRL", fullName: "Brazilian Real"),
    Symbol(symbol: "EUR", fullName: "Euro"),
    Symbol(symbol: "GBP", fullName: "British Pound Sterling"),
    Symbol(symbol: "JPY", fullName: "Japanese Yen"),
    Symbol(symbol: "USD", fullName: "United States Dollar")
    ]
}

struct CurrencySelectionFilterView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel = CurrencySelectionFilterViewModel()
    @State private var selections: [String] = []
    @State private var searchText = ""
   
    var searchesResult: [Symbol] {
        if searchText.isEmpty {
            return viewModel.symbols
        } else {
            return viewModel.symbols.filter {
                $0.symbol.contains(searchText.uppercased()) ||
                $0.fullName.uppercased().contains(searchText.uppercased())
            }
        }
    }
    

    var body: some View {
        NavigationView {
            listCurrencyView
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

struct CurrencySelectionFilterView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencySelectionFilterView()
    }
}
