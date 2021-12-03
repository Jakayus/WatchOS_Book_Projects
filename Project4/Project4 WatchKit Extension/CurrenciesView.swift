//
//  CurrenciesView.swift
//  Project4 WatchKit Extension
//
//  Created by Joel Sereno on 11/30/21.
//

import SwiftUI

struct CurrenciesView: View {
    
    @State private var selectedCurrencies = UserDefaults.standard.array(forKey: ContentView.selectedCurrenciesKey) as? [String] ?? ContentView.defaultCurrencies
    
    let selectedColor = Color(red: 0, green: 0.55, blue: 0.25)
    let deselectedColor = Color(red: 0.3, green: 0, blue: 0)
    
    var body: some View {
        List {
            ForEach(ContentView.currencies, id: \.self) { currency in
                Button(currency) {
                    toggle(currency)
                }
                .listItemTint(selectedCurrencies.contains(currency) ? selectedColor : deselectedColor)
            }
        }
        .listStyle(CarouselListStyle())
        .navigationTitle("Currencies")
        
    }
    
    func toggle(_ currency: String) {
        if let index = selectedCurrencies.firstIndex(of: currency) {
            //if the currency is in selected currencies, remove it
            selectedCurrencies.remove(at: index)
        } else {
            selectedCurrencies.append(currency)
        }
        
        //save the new currencies
        UserDefaults.standard.set(selectedCurrencies, forKey: ContentView.selectedCurrenciesKey)
    }
}

struct CurrenciesView_Previews: PreviewProvider {
    static var previews: some View {
        CurrenciesView()
    }
}
