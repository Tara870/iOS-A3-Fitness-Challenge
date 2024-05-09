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

    var body: some View {
        VStack {
            MapView(locationManager: locationManager)
                .frame(height: 300)

            HStack {
                Text("Heart Rate: \(healthKitManager.heartRate, specifier: "%.0f") bpm")
                Text("Distance: \(healthKitManager.distance, specifier: "%.2f") km")
            }
            .padding()

            Button(action: toggleRun) {
                Text(isRunning ? "Stop Run" : "Start Run")
                    .foregroundColor(.white)
                    .padding()
                    .background(isRunning ? Color.red : Color.green)
                    .cornerRadius(8)
            }

            Spacer()
        }
        .padding()
    }

    private func toggleRun() {
        if isRunning {
            healthKitManager.stopRun()
        } else {
            healthKitManager.startRun(locationManager)
        }
        isRunning.toggle()
    }
}

    
#Preview {
    RunningView()
}
