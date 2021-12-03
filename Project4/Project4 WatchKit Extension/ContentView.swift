//
//  ContentView.swift
//  Project4 WatchKit Extension
//
//  Created by Joel Sereno on 11/27/21.
//

import SwiftUI

struct ContentView: View {
    @State private var amount = 500.0
    @State private var selectedCurrency = "USD"
    @State private var selectedCurrencies = UserDefaults.standard.array(forKey: ContentView.selectedCurrenciesKey) as? [String] ?? ContentView.defaultCurrencies
    
    static let currencies = ["USD", "AUD", "CAD", "CHF", "CNY", "EUR", "GBP", "HKD", "JPY", "SGD"] //static will allow the array to be used elsewhere in the app
    static let selectedCurrenciesKey = "SelectedCurrencies"
    static let defaultCurrencies = ["USD", "EUR"]
    
    
    
    var body: some View {
        
        GeometryReader { geo in
            VStack (spacing: 0) {
                Text("\(Int(amount))")
                    .font(.system(size: 52))
                    .frame(height: geo.size.height / 3)
                
                Slider(value: $amount, in: 0...1000, step: 20)
                    .accentColor(.green)
                    .frame(height: geo.size.height / 3)
                //Slider notes
                //1. move between 0 and 1000 inclusive
                //2. sets the step count to 20 (up/down by 20)
                //3. two way binding for amount property
                HStack {
                    Picker("Select a currency", selection: $selectedCurrency) {
                        ForEach(Self.currencies, id: \.self) { currency in
                            Text(currency)
                        }
                    }//end Picker
                    .labelsHidden()
                    
                    NavigationLink(destination: Text("Detail View")) {
                        Text("Go")
                    }
                    .frame(width: geo.size.width * 0.4) //40% of available width
                }
                .frame(height: geo.size.height / 3)
                
                //Picker notes
                //1. two way binding to selectedCurrency
                //2. ForEach loops over all items in currencies to create items. Self refers to static property currencies
                //3. each item looped is converted into a TextView
                //4. modifier hides picker label
                
            }//end VStack
            .navigationTitle("WatchFX")
            
        }//end Geometry Reader
    }//end View
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
