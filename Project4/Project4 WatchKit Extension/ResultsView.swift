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
    @State var ApiKey: String
    
    var body: some View {
        Text("Hello, World! \(ApiKey)")
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(amount: 500, baseCurrency: "USD", ApiKey: "test")
    }
}
