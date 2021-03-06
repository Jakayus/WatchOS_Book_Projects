//
//  ContentView.swift
//  Project10 WatchKit Extension
//
//  Created by Joel Sereno on 12/30/21.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    //MARK: - Properties
    let activities: [(name: String, type: HKWorkoutActivityType)] = [
        ("Cycling", .cycling),
        ("Running", .running),
        ("Wheelchair", .wheelchairRunPace)
    
    ]
    
    @State private var selectedActivity = 0
    
    @StateObject var dataManager = DataManager() //@StateObject allows you to watch a class for changes
    
    
    //MARK: - View
    var body: some View {
        //Display view if workout is not active
        if dataManager.state == .inactive {
            VStack {
//                Picker("Choose an activity", selection: $selectedActivity) {
//                    ForEach(0..<activities.count) { index in
//                        Text(activities[index].name)
//                    }
//                }
                
                List {
                    ForEach(0..<activities.count, id: \.self) { index in
                        Button {
                            guard HKHealthStore.isHealthDataAvailable() else { return }
                            
                            dataManager.activity = activities[selectedActivity].type
                            dataManager.start()
                        } label: {
                            Text(activities[index].0)
                        }

                    }
                }
                
                
//                Button("Start Workout") {
//                    guard HKHealthStore.isHealthDataAvailable() else { return }
//
//                    dataManager.activity = activities[selectedActivity].type
//                    dataManager.start()
//                }
            }//end VStack
        } else {
            WorkoutView(dataManager: dataManager, endWorkout: false)
        }
    }//end View
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
