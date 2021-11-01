//
//  Project1App.swift
//  Project1 WatchKit Extension
//
//  Created by Joel Sereno on 10/31/21.
//

import SwiftUI

@main
struct Project1App: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
