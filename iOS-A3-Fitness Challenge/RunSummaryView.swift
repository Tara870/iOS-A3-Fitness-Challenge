//
//  RunSummaryView.swift
//  iOS-A3-Fitness Challenge
//
//  Created by David Karibian on 5/12/24.
//

import SwiftUI

struct RunSummaryView: View {
    var timeElapsed: String
    var distance: Double
    var heartRate: Double
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Run Summary")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)
            
            HStack {
                Image(systemName: "clock")
                    .foregroundColor(.white)
                    .font(.title)
                VStack(alignment: .leading) {
                    Text("Time")
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.8))
                    Text(timeElapsed)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.white)
                }
            }
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(12)
            .shadow(radius: 8)
            
            HStack {
                Image(systemName: "figure.walk")
                    .foregroundColor(.white)
                    .font(.title)
                VStack(alignment: .leading) {
                    Text("Distance")
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.8))
                    Text("\(String(format: "%.2f", distance)) km")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.white)
                }
            }
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(12)
            .shadow(radius: 8)
            
            HStack {
                Image(systemName: "heart.fill")
                    .foregroundColor(.white)
                    .font(.title)
                VStack(alignment: .leading) {
                    Text("Average Heart Rate")
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.8))
                    Text("\(Int(heartRate)) bpm")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.white)
                }
            }
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(12)
            .shadow(radius: 8)
            
            Spacer()
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.3), Color.black.opacity(0.7)]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}

