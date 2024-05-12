//
//  ProfileIconView.swift
//  iOS-A3-Fitness Challenge
//
//  Created by Tara Jiang on 11/5/2024.
//

import SwiftUI

struct ProfileIconView: View {
    @EnvironmentObject var authViewModel : AuthViewModel
    
    var body: some View {
        
        NavigationStack {
            // check if current user exists
            if let user = authViewModel.currentUser {
                NavigationLink(destination: ProfileView(user: user)) {
                    HStack {
                        Image("profile")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .padding(.vertical, 32)
                    }
                    Spacer()
                }
            }
        }
        
        
    }
}

#Preview {
    ProfileIconView()
}
