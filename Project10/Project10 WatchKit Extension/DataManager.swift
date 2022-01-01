//
//  DataManager.swift
//  Project10 WatchKit Extension
//
//  Created by Joel Sereno on 12/30/21.
//

import Foundation
import HealthKit

class DataManager: NSObject, ObservableObject, HKWorkoutSessionDelegate, HKLiveWorkoutBuilderDelegate {
   

    enum WorkoutState {
        case inactive, active, paused
    }
    
    var healthStore = HKHealthStore()
    var workoutSession: HKWorkoutSession?
    var workoutBuilder: HKLiveWorkoutBuilder?
    
    var activity = HKWorkoutActivityType.cycling
    
    @Published var state  = WorkoutState.inactive
    @Published var totalEnergyBurned = 0.0
    @Published var totalDistance = 0.0
    @Published var lastHeartRate = 0.0
    
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
        let config = HKWorkoutConfiguration()
        config.activityType = activity
        config.locationType = .outdoor
        
        //creating a workout session will fail if you pass in an invalid configuration
        do {
            workoutSession = try HKWorkoutSession(healthStore: healthStore, configuration: config)
            workoutBuilder = workoutSession?.associatedWorkoutBuilder()
            workoutBuilder?.dataSource = HKLiveWorkoutDataSource(healthStore: healthStore, workoutConfiguration: config)
            
            workoutSession?.delegate = self
            workoutBuilder?.delegate = self
            
            workoutSession?.startActivity(with: Date())
            workoutBuilder?.beginCollection(withStart: Date()) { success, error in
                guard success else {
                    return
                }
                
                //as this work affects user interface, it is conducted on the main thread
                DispatchQueue.main.async {
                    self.state = .active
                }
            }
            
        } catch {
            //Handle errors here
        }
    }
    
    //Delegate required stubs
    func workoutSession(_ workoutSession: HKWorkoutSession, didChangeTo toState: HKWorkoutSessionState, from fromState: HKWorkoutSessionState, date: Date) {
        
    }
    
    func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: Error) {
        
    }
    
    func workoutBuilder(_ workoutBuilder: HKLiveWorkoutBuilder, didCollectDataOf collectedTypes: Set<HKSampleType>) {
        for type in collectedTypes{
            guard let quantityType = type as? HKQuantityType else { continue }
            guard let statistics = workoutBuilder.statistics(for: quantityType) else { continue }
            
            DispatchQueue.main.async {
                switch statistics.quantityType {
                case HKQuantityType.quantityType(forIdentifier: .heartRate):
                    let heartRateUnit = HKUnit.count().unitDivided(by: .minute())
                    self.lastHeartRate = statistics.mostRecentQuantity()?.doubleValue(for: heartRateUnit) ?? 0
                
                case HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned):
                    let value = statistics.sumQuantity()?.doubleValue(for: .kilocalorie()) ?? 0
                    self.totalEnergyBurned = value
                    
                default:
                    let value = statistics.sumQuantity()?.doubleValue(for: .meter())
                    self.totalDistance = value ?? 0
                }
            }
        }
    }
    
    func workoutBuilderDidCollectEvent(_ workoutBuilder: HKLiveWorkoutBuilder) {
        
    }
    

}


 
