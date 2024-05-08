//
//  iOS_A3_Fitness_ChallengeApp.swift
//  iOS-A3-Fitness Challenge
//
//  Created by Tara Jiang on 6/5/2024.
//

import SwiftUI
import Firebase

@main
struct iOS_A3_Fitness_ChallengeApp: App {
    @StateObject var authViewModel = AuthViewModel() // initialise only once
    
    // configure firebase
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
        }
    }
}
