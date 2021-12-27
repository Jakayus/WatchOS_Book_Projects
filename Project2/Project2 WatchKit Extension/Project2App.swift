//
//  Project2App.swift
//  Project2 WatchKit Extension
//
//  Created by Joel Sereno on 11/21/21.
//

import SwiftUI

@main
struct Project2App: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView( isCorrect: false)
            }
        }
    }
}
