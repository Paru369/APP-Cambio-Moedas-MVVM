//
//  BaseCurrencyFilterView.swift
//  ExchangeRates
//
//  Created by Paulo Pinheiro on 8/31/23.
//

import SwiftUI



class BaseCurrencyFilterViewModel: ObservableObject {
@Published var symbols: [CurrencySymbolModel] = [
    CurrencySymbolModel(symbol:"BRL", fullName: "Brazilian Real"),
    CurrencySymbolModel(symbol: "EUR", fullName: "Euro"),
    CurrencySymbolModel(symbol: "GBP", fullName: "British Pound Sterling"),
    CurrencySymbolModel(symbol: "JPY", fullName: "Japanese Yen"),
    CurrencySymbolModel(symbol: "USD", fullName: "United States Dollar")
    ]
}


struct BaseCurrencyFilterView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel = BaseCurrencyFilterViewModel()
    
    @State private var selection: String?
    
    @State private var searchText = ""
    
    var searchesResult: [CurrencySymbolModel] {
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

struct BaseCurrencyFilterView_Previews: PreviewProvider {
    static var previews: some View {
        BaseCurrencyFilterView()
    }
}
