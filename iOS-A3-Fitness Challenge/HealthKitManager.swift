//
//  HealthKitManager.swift
//  iOS-A3-Fitness Challenge
//
//  Created by David Karibian on 5/9/24.
//

import Foundation
import HealthKit
import MapKit
import CoreLocation

class HealthKitManager: NSObject, ObservableObject {
    private let healthStore = HKHealthStore()
    private var heartRateObserver: HKObserverQuery?
    private var distanceObserver: HKObserverQuery?
    private var locationManager: LocationManager?
    
    @Published var heartRate: Double = 0.0
    @Published var distance: Double = 0.0
    
    override init() {
        super.init()
        // Check if HealthKit is available
        if HKHealthStore.isHealthDataAvailable() {
            requestHealthKitPermissions()
        } else {
            print("HealthKit is not available on this device.")
        }
    }
    
    func requestHealthKitPermissions() {
        guard let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate),
              let distanceType = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning) else {
            print("HealthKit types are not available.")
            return
        }
        let typesToShare: Set<HKSampleType> = [heartRateType, distanceType]
        let typesToRead: Set<HKObjectType> = [heartRateType, distanceType]
        
        healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead) { (success, error) in
            if success {
                self.setupHealthKitQueries()
            } else {
                print("Failed to authorize HealthKit: \(String(describing: error))")
            }
        }
    }
    
    func setupHealthKitQueries() {
        guard let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate),
              let distanceType = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning) else {
            print("HealthKit types are not available.")
            return
        }
        heartRateObserver = HKObserverQuery(sampleType: heartRateType, predicate: nil) { (query, completionHandler, error) in
            if let error = error {
                print("Heart rate observer query failed: \(error.localizedDescription)")
                return
            }
            
            let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
            let sampleQuery = HKSampleQuery(sampleType: heartRateType, predicate: nil, limit: 1, sortDescriptors: [sortDescriptor]) { (query, samples, error) in
                guard let samples = samples as? [HKQuantitySample] else {
                    completionHandler()
                    return
                }
                
                self.updateHeartRate(samples)
                completionHandler()
            }
            self.healthStore.execute(sampleQuery)
        }
        healthStore.execute(heartRateObserver!)
        
        distanceObserver = HKObserverQuery(sampleType: distanceType, predicate: nil) { (query, completionHandler, error) in
            if let error = error {
                print("Distance observer query failed: \(error.localizedDescription)")
                return
            }
            
            let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
            let sampleQuery = HKSampleQuery(sampleType: distanceType, predicate: nil, limit: 1, sortDescriptors: [sortDescriptor]) { (query, samples, error) in
                guard let samples = samples as? [HKQuantitySample] else {
                    completionHandler()
                    return
                }
                
                self.updateDistance(samples)
                completionHandler()
            }
            self.healthStore.execute(sampleQuery)
        }
        healthStore.execute(distanceObserver!)
    }
    
    func updateHeartRate(_ samples: [HKSample]) {
        guard let lastSample = samples.last as? HKQuantitySample else { return }
        let heartRateValue = lastSample.quantity.doubleValue(for: HKUnit.count().unitDivided(by: .minute()))
        heartRate = heartRateValue
    }
    
    func updateDistance(_ samples: [HKSample]) {
        var totalDistance: Double = 0
        for sample in samples {
            guard let quantitySample = sample as? HKQuantitySample else { continue }
            let distanceValue = quantitySample.quantity.doubleValue(for: HKUnit.meter())
            totalDistance += distanceValue
        }
        distance = totalDistance / 1000 // Convert meters to kilometers
    }
    
    func startRun(_ locationManager: LocationManager) {
        self.locationManager = locationManager
        locationManager.startUpdatingLocation()
        
        let config = HKWorkoutConfiguration()
        config.activityType = .running
        config.locationType = .outdoor
        
        let workoutBuilder = HKWorkoutBuilder(healthStore: healthStore, configuration: config, device: nil)
        workoutBuilder.beginCollection(withStart: Date()) { (success, error) in
            if success {
                // Workout started successfully
            } else {
                print("Failed to start the workout: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
    
    func stopRun() {
        locationManager?.stopUpdatingLocation()
        
        let config = HKWorkoutConfiguration()
        config.activityType = .running
        config.locationType = .outdoor
        let workoutBuilder = HKWorkoutBuilder(healthStore: healthStore, configuration: config, device: nil)
        
        workoutBuilder.finishWorkout { (workout, error) in
            if let error = error {
                print("Failed to finish the workout: \(error.localizedDescription)")
            }
        }
    }
}
