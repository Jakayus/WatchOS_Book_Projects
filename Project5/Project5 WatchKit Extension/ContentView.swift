//
//  ContentView.swift
//  Project5 WatchKit Extension
//
//  Created by Joel Sereno on 12/12/21.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    
    //MARK: - Properties
    let colors = [
        "Red": Color(red:1, green: 0, blue: 0),
        "Green": Color(red: 0, green: 0.5, blue: 0),
        "Blue": Color(red: 0, green: 0, blue: 1),
        "Orange": Color(red: 1, green: 0.6, blue: 0),
        "Purple": Color(red: 0.5, green: 0, blue: 0.5),
        "Black" : Color.black
    ]
    
    @State private var colorKeys = ["Red", "Green", "Blue", "Orange", "Purple", "Black"]
    @State private var correctAnswer = 0
    @State private var currentLevel = 0
    @State private var gameOver = false
    @State private var title = ""
    @State private var startTime = Date()
    
    //MARK: - View
    var body: some View {
        VStack(spacing: 10) {
            HStack (spacing: 10){
                text(for: 0)
                text(for: 1)
            }
            HStack (spacing: 10) {
                text(for: 2)
                text(for: 3)
            }
        }
        .navigationTitle(title)
        .onAppear(perform: startNewGame)
        .sheet(isPresented: $gameOver) {
            //sheet content here
            VStack {
                Text("You win!")
                    .font(.largeTitle)
                Text("You finished in \(Int(Date().timeIntervalSince(startTime))) seconds")
                Button("Play Again", action: startNewGame) //no parantheses as we are passing the function directly, instead of calling it then passing whatever the function sends back
            }
        }
    }
    
    //MARK: - Methods
    
    //NOTE: this function returns a View, which is then used within the View property above
    func text(for index: Int) -> some View {
        let title: String
        
        if index == correctAnswer {
            title = colorKeys[colorKeys.count - 1] //use index value that is not part of 0-3
        } else {
            title = colorKeys[index]
        }
        
        //NOTE: after returning a View, modifiers can be applied
        return Text(title)
            .frame(maxWidth: .infinity, maxHeight: .infinity) //.infinity takes up all available space
            .background(colors[colorKeys[index]]) //modifier order matters - apply frame THEN background
            .cornerRadius(20)
            .onTapGesture {
                tapped(index)
            }
    }
    
    func createLevel() {
        title = "Level \(currentLevel)/10"
        
        correctAnswer = Int.random(in: 0...3)
        colorKeys.shuffle() //only the first 4 colors (index 0-3) are used
    }
    
    func startNewGame() {
        currentLevel = 1
        gameOver = false
        createLevel()
        startTime = Date() //reset whenever a new game is started
        setPlayReminder()
    }
    
    func tapped(_ index: Int){
        //current level goes up/down depending on valid answer
        if index == correctAnswer {
            currentLevel += 1
        } else {
            if currentLevel > 1 {
                currentLevel -= 1
            }
        }
        
        if currentLevel == 11 {
            gameOver = true
        }
        createLevel()
    }
    
    func createNotification() {
        let center = UNUserNotificationCenter.current()
        
        //basic notification content configuration (what to show)
        let content = UNMutableNotificationContent()
        content.title = "We miss you!"
        content.body = "Come back and play the game some more!"
        content.categoryIdentifier = "play_reminder" //category
        content.sound = .default
        
        //trigger (when to show it)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        //content and trigger must come in the form of a request
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    func setPlayReminder() {
        let center = UNUserNotificationCenter.current()
        
        //alert and sound options chosen
        center.requestAuthorization(options: [.alert, .sound]) { success, error in
            if success {
                registerCategories()
                center.removeAllPendingNotificationRequests()
                createNotification()
                
            }
        }
    }
    
    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        
        let play = UNNotificationAction(identifier: "play", title: "Play Now", options: .foreground)
        let category = UNNotificationCategory(identifier: "play_reminder", actions: [play], intentIdentifiers: [])
        
        center.setNotificationCategories([category])
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
