//
//  ContentView.swift
//  Project4 WatchKit Extension
//
//  Created by Joel Sereno on 11/27/21.
//

import SwiftUI

struct ContentView: View {
    @State private var amount:Double = 500 //UserDefaults.standard.double(forKey: "amount")

    @State private var selectedCurrency = "USD"
    @State private var selectedCurrencies = UserDefaults.standard.array(forKey: ContentView.selectedCurrenciesKey) as? [String] ?? ContentView.defaultCurrencies
    @State private var amountFocused = false
    
    
    static let currencies = ["USD", "AUD", "CAD", "CHF", "CNY", "EUR", "GBP", "HKD", "JPY", "SGD"] //static will allow the array to be used elsewhere in the app
    static let selectedCurrenciesKey = "SelectedCurrencies"
    static let defaultCurrencies = ["USD", "EUR"]
    
    
    //instead of calling function, we are using a computed String for API key
    private var apiKey: String {
      get {
        // 1
        guard let filePath = Bundle.main.path(forResource: "OER-Info", ofType: "plist") else {
          fatalError("Couldn't find file 'OER-Info.plist'.")
        }
        // 2
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
          fatalError("Couldn't find key 'API_KEY' in 'OER-Info.plist'.")
        }
        // 3
        if (value.starts(with: "_")) {
          fatalError("Register for an API key at Open Exchange Rates.")
        }
        return value
      }
    }
    
    
    
    
    
    var body: some View {
        
        GeometryReader { geo in
            VStack (spacing: 0) {
                Text("\(Int(amount))")
                    .font(.system(size: 52))
                    .padding()
                    .frame(width: geo.size.width)
                    .contentShape(Rectangle())
                    .focusable()
                    .digitalCrownRotation($amount, from: 0, through: 1000, by: 20, sensitivity: .high, isContinuous: false, isHapticFeedbackEnabled: true)
                    .overlay (
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(amountFocused ? Color.green : Color.white, lineWidth: 1)
                    )
                    .padding(.bottom)
                //focusable modifier tells watchOS that this text view can ber focused
                //sensitivity controls how far the user needs to turn the crown in order to move the value
                //isContinuous controls whhether value should wrap
                //isHapticFeedbackEnabled controls if Taptic Engine creates feedback as the crown is turned
                
                
                HStack {
                    Picker("Select a currency", selection: $selectedCurrency) {
                        ForEach(Self.currencies, id: \.self) { currency in
                            Text(currency)
                        }
                    }//end Picker
                    .labelsHidden()
                    
                    NavigationLink(destination: ResultsView(amount: amount, baseCurrency: selectedCurrency, apiKey: apiKey)) {
                        Text("Go")
                    }
                    .frame(width: geo.size.width * 0.4) //40% of available width
                    .onTapGesture {
                        saveData()
                    }
                }
                .frame(height: geo.size.height / 3)
                
                //Picker notes
                //1. two way binding to selectedCurrency
                //2. ForEach loops over all items in currencies to create items. Self refers to static property currencies
                //3. each item looped is converted into a TextView
                //4. modifier hides picker label
                
            }//end VStack
            .navigationTitle("WatchFX")
            .onAppear {
                print(apiKey)
                //checkAPI()
                loadData()
            }
        }//end Geometry Reader
    }//end View
    
    //Useful code snippet for watchOS - it asks for the app's documents directory
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func saveData() {
        UserDefaults.standard.set(selectedCurrency, forKey: "selectedCurrency")
        UserDefaults.standard.set(amount, forKey: "amount")
    }
    
    func loadData() {
        selectedCurrency = UserDefaults.standard.string(forKey: "selectedCurrency") ?? "USD"
        amount = UserDefaults.standard.double(forKey: "amount")
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
