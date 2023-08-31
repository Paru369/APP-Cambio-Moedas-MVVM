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
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct BaseCurrencyFilterView_Previews: PreviewProvider {
    static var previews: some View {
        BaseCurrencyFilterView()
    }
}
