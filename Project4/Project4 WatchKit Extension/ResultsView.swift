//
//  ResultsView.swift
//  Project4 WatchKit Extension
//
//  Created by Joel Sereno on 12/2/21.
//

import SwiftUI

enum FetchState{
    case fetching, success, failed
}


struct ResultsView: View {
    
    @State private var fetchState = FetchState.fetching
    @State private var fetchedCurrencies = [(symbol: String, rate: Double)]()
    
    let amount: Double
    let baseCurrency: String
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(amount: 500, baseCurrency: "USD")
    }
}
