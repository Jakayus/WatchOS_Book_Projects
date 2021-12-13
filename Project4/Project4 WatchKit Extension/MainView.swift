//
//  MainView.swift
//  Project4 WatchKit Extension
//
//  Created by Joel Sereno on 11/30/21.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ContentView()
            CurrenciesView()
            DefaultValues()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
