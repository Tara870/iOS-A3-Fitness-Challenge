//
//  ContentView.swift
//  iOS-A3-Fitness Challenge
//
//  Created by Tara Jiang on 6/5/2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        Group {
            // if user has already logged in - menu
            // otherwise log in view
            if authViewModel.userSession != nil {
                // change it to the actual menu page
                ProfileIconView()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
    
}
