//
//  BaseCurrencyFilterView.swift
//  ExchangeRates
//
//  Created by Paulo Pinheiro on 8/31/23.
//

import SwiftUI

struct Symbol: Identifiable, Equatable {
    let id = UUID()
    var symbol: String
    var fullName: String
}

class BaseCurrencyFilterViewModel: ObservableObject {
@Published var symbols: [Symbol] = [
    Symbol(symbol:"BRL", fullName: "Brazilian Real"),
    Symbol(symbol: "EUR", fullName: "Euro"),
    Symbol(symbol: "GBP", fullName: "British Pound Sterling"),
    Symbol(symbol: "JPY", fullName: "Japanese Yen"),
    Symbol(symbol: "USD", fullName: "United States Dollar")
    ]
}


struct BaseCurrencyFilterView: View {
    
    @StateObject var viewModel = BaseCurrencyFilterViewModel()
    
    @State private var selection: String?
    
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
        List(searchesResult, id: \.symbol, selection: $selection) { item in
            HStack {
                Text(item.symbol)
                    .font(.system(size: 14, weight: .bold))
                Text("-")
                    .font(.system(size: 14, weight: .semibold))
                Text(item.fullName)
                    .font(.system(size: 14, weight: .semibold))
            }
        }
        .searchable(text: $searchText)
        .navigationTitle("Filter Currencies")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                print("Select currency button")
            } label: {
                Text("OK")
                    .fontWeight(.bold
                    )
            }
        }
    }
    
  
}

struct BaseCurrencyFilterView_Previews: PreviewProvider {
    static var previews: some View {
        BaseCurrencyFilterView()
    }
}
