//
//  WorkoutView.swift
//  Project10 WatchKit Extension
//
//  Created by Joel Sereno on 12/30/21.
//

import SwiftUI

struct WorkoutView: View {
    
    //MARK: - Properties
    enum DisplayMode {
        case distance, energy, heartRate
    }
    
    @State private var displayMode = DisplayMode.distance
    @ObservedObject var dataManager: DataManager
    
    var quantity: String {
        
        switch displayMode {
        case .distance:
            let kilometers = dataManager.totalDistance / 1000
            return String(format: "%.2f", kilometers)
        
        case .energy:
            return String(format: "%.0f", dataManager.totalEnergyBurned)
            
        case .heartRate:
            return String(Int(dataManager.lastHeartRate))
        }
}
    
    var unit: String {
        switch displayMode {
        case .distance:
            return "kilometers"
        case .energy:
            return "calories"
        case .heartRate:
            return "beats / minute"
        }
    }
    

    //MARK: - View
    var body: some View {
        VStack {
            Group {
                Text(quantity)
                    .font(.largeTitle)
                Text(unit)
                    .textCase(.uppercase)
            }
            .onTapGesture(perform: changeDisplayMode)
            
            if dataManager.state == .active {
                Button("Stop", action: {dataManager.pause()})
            } else {
                Button("Resume", action: {dataManager.resume()})
                Button("End", action: {dataManager.end()})
            }
            
            
        }
    }
    
    //MARK: -  Methods
    
    func changeDisplayMode() {
        switch displayMode {
        case .distance:
            displayMode = .energy
        case .energy:
            displayMode = .heartRate
        case .heartRate:
            displayMode = .distance
        }
    }

}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView(dataManager: DataManager())
    }
}
