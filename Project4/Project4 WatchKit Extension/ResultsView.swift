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
        Group {
            if fetchState == .success {
                List {
                    ForEach (fetchedCurrencies, id: \.symbol) { currency in
                        Text(rate(for: currency))
                    }
                }
            } else {
                Text(fetchState == .fetching ? "Fetching..." : "Fetch failed")
            }
        }
        .onAppear(perform: fetchData)
        .navigationTitle("\(Int(amount)) \(baseCurrency)")
    }
    
    
    //MARK: - Methods
    func parse(result: CurrencyResult) {
        
        //1. fetch data and determine if fetch is successful by checking rates within results
        //2. read the user's list of currencies or otherwise use default
        //3. loop rates received from OER
        //4. if the currency is in selected currencies list, add its symbol and value to fetchedCurrencies array
        //5. sort the array after all currencies received
        
        if result.rates.isEmpty {
            //fetch error
            fetchState = .failed
        } else {
            //fetch succeeded
            fetchState = .success
            
            //read the user's selected currencies
            let selectedCurrencies = UserDefaults.standard.array(forKey: ContentView.selectedCurrenciesKey) as? [String] ?? ContentView.defaultCurrencies
            
            for symbol in result.rates {
                //filter the rates so we only show ones the user cares about
                guard selectedCurrencies.contains(symbol.key) else { continue }
                let rateName = symbol.key
                let rateValue = symbol.value
                fetchedCurrencies.append((symbol: rateName, rate: rateValue))
            }
            
            fetchedCurrencies.sort { $0.symbol < $1.symbol}
        }
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
    
    func rate(for currency: (symbol: String, rate: Double)) -> String {
        //1. take in a currency tuple (symbol and rate)
        //2. multiply the rate by how much the user asked to convert to
        //3. format rate as string (2 decimal places)
        //4. return a string with symbol and rate
        
        let value = currency.rate * amount
        let rate = String(format: "%.2f", value)
        return "\(currency.symbol) \(rate)"
    }
    
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(amount: 500, baseCurrency: "USD", apiKey: "test")
    }
}
