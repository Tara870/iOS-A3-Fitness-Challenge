//
//  iOS_A3_Fitness_ChallengeApp.swift
//  iOS-A3-Fitness Challenge
//
//  Created by Tara Jiang on 6/5/2024.
//

import SwiftUI
import Firebase

//import FirebaseCore
//
//class AppDelegate: NSObject, UIApplicationDelegate {
//  func application(_ application: UIApplication,
//                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//    FirebaseApp.configure()
//    return true
//  }
//}

@main
struct iOS_A3_Fitness_ChallengeApp: App {
    @StateObject var authViewModel = AuthViewModel() // initialise only once
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
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
