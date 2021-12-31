//
//  DataManager.swift
//  Project10 WatchKit Extension
//
//  Created by Joel Sereno on 12/30/21.
//

import Foundation
import HealthKit

class DataManager {
    enum WorkoutState {
        case inactive, active, paused
    }
    
    var healthStore = HKHealthStore()
    var workoutSession: HKWorkoutSession?
    var workoutBuilder: HKLiveWorkoutBuilder?
    
    var activity = HKWorkoutActivityType.cycling
    
    var state  = WorkoutState.inactive

    func start() {
        let sampleTypes: Set<HKSampleType> = [
        
            .workoutType(),
            .quantityType(forIdentifier: .heartRate)!,
            .quantityType(forIdentifier: .activeEnergyBurned)!,
            .quantityType(forIdentifier: .distanceCycling)!,
            .quantityType(forIdentifier: .distanceWalkingRunning)!,
            .quantityType(forIdentifier: .distanceWheelchair)!
        ]
        
        healthStore.requestAuthorization(toShare: sampleTypes, read: sampleTypes) { success, error in
            if success {
                self.beginWorkout()
            }
        }
    }//end start function
    
    private func beginWorkout() {
        
    }

}


 
