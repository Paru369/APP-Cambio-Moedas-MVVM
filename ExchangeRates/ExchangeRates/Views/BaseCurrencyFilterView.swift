//
//  BaseCurrencyFilterView.swift
//  ExchangeRates
//
//  Created by Paulo Pinheiro on 8/31/23.
//

import SwiftUI

protocol BaseCurrencyFilterViewDelegate {
    func didSelected(_ baseCurrency: String)
}

struct BaseCurrencyFilterView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel = ViewModel()
    
    @State private var selection: String?
    @State private var searchText = ""
    
    var delegate: BaseCurrencyFilterViewDelegate?
    
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
                delegate?.didSelected(selection ?? "BRL")
                dismiss()
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