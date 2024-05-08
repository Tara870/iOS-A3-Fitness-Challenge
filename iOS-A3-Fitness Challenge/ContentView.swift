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
            if authViewModel.userSession != nil {
                ProfileView()
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
    
}
