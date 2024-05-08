//
//  iOS_A3_Fitness_ChallengeApp.swift
//  iOS-A3-Fitness Challenge
//
//  Created by Tara Jiang on 6/5/2024.
//

import SwiftUI

@main
struct iOS_A3_Fitness_ChallengeApp: App {
    @StateObject var authViewModel = AuthViewModel() // initialise only once
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
        }
    }
}
