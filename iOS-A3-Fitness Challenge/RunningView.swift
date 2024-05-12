//
//  RunningView.swift
//  iOS-A3-Fitness Challenge
//
//  Created by David Karibian on 5/9/24.
//

import SwiftUI

struct RunningView: View {
    @StateObject private var locationManager = LocationManager()
    @StateObject private var healthKitManager = HealthKitManager()
    
    @State private var isRunning = false
    @State private var showSummary = false
    @State private var startTime: Date?
    @State private var endTime: Date?
    
    var timeElapsed: String {
        guard let start = startTime, let end = endTime else { return "0:00" }
        let interval = Int(end.timeIntervalSince(start))
        let minutes = interval / 60
        let seconds = interval % 60
        return String(format: "%d:%02d", minutes, seconds)
    }

    var body: some View {
        VStack {
            if showSummary {
                RunSummaryView(timeElapsed: timeElapsed, distance: healthKitManager.distance, heartRate: healthKitManager.heartRate)
            } else {
                MapView(locationManager: locationManager)
                    .frame(height: 300)
                    .cornerRadius(20)
                    .shadow(radius: 10)

                HStack(spacing: 30) {
                    VStack {
                        Text("Heart Rate")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("\(healthKitManager.heartRate, specifier: "%.0f") bpm")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    
                    VStack {
                        Text("Distance")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("\(healthKitManager.distance, specifier: "%.2f") km")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                }
                .padding()

                Button(action: toggleRun) {
                    HStack {
                        Image(systemName: isRunning ? "stop.circle" : "play.circle")
                            .font(.title)
                        Text(isRunning ? "Stop Run" : "Start Run")
                            .fontWeight(.bold)
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(height: 50)
                    .background(isRunning ? Color.red : Color.green)
                    .cornerRadius(25)
                    .shadow(radius: 5)
                }

                Spacer()
            }
        }
        .padding()
    }

    private func toggleRun() {
        if isRunning {
            healthKitManager.stopRun()
            endTime = Date()
            showSummary = true
        } else {
            healthKitManager.startRun(locationManager)
            startTime = Date()
            endTime = nil
            showSummary = false
        }
        isRunning.toggle()
    }
}
    
#Preview {
    RunningView()
}
