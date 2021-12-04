//
//  ResultsView.swift
//  Project4 WatchKit Extension
//
//  Created by Joel Sereno on 12/2/21.
//

import SwiftUI
import Combine

enum FetchState{
    case fetching, success, failed
}


struct ResultsView: View {
    
    //MARK: - Properties
    @State private var fetchState = FetchState.fetching
    @State private var fetchedCurrencies = [(symbol: String, rate: Double)]() //convert OER dictionary data as a tuple array
    
    let amount: Double
    let baseCurrency: String
    
    @State var apiKey: String //appID
    @State private var request: AnyCancellable? //known as a 'type eraser'
    
    
    //MARK: - View
    var body: some View {
        Text("Hello, World! \(apiKey)")
    }
    
    
    //MARK: - Methods
    func parse(result: CurrencyResult) {
        
    }
    
    func fetchData() {
        if let url = URL(string: "https://openexchangerates.org/api/latest.json?app_id=\(apiKey)&base=\(baseCurrency)") {
            //if URL exists
            //1. fetch URL using Apple's networking session URLSession
            //2. read the data that gets sent back
            //3. Decode into currencyResult
            //4. Error handling - replace it with empty CurrencyResult if error in decoding
            //5. move back to main thread
            //6. send CurrencyResult to parse
            
            
            request = URLSession.shared.dataTaskPublisher(for: url) //creats a publisher
                .map(\.data) //either we get data or get an error
                .decode(type: CurrencyResult.self, decoder: JSONDecoder())
                .replaceError(with: CurrencyResult(base: "", rates: [:]))
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: parse)
        }
    }
    
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(amount: 500, baseCurrency: "USD", apiKey: "test")
    }
}
