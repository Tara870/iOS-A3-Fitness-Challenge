//
//  ProfileView.swift
//  iOS-A3-Fitness Challenge
//
//  Created by Tara Jiang on 8/5/2024.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authViewModel : AuthViewModel
    var user : User?
    
    var body: some View {
//        if let user = authViewModel.currentUser {
        if let user = user {
            List {
                Section {
                    HStack {
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 72, height: 72)
                            .background(Color(.systemGray3))
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(user.fullName)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                            
                            Text(user.email)
                                .font(.footnote)
                                .foregroundStyle(.gray)
                        }
                    }
                }
                
                Section("General") {
                    HStack {
                        SettingRowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray))
                        Spacer()
                        Text("1.0.0")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                
                Section("Account") {
                    Button {
                        authViewModel.signOut()
                    } label: {
                        SettingRowView(
                            imageName: "arrow.left.circle.fill",
                            title: "Sign Out",
                            tintColor: .red)
                    }
                    
                    Button {
                        Task {
                            try await authViewModel.deleteUser()
                        }
                    } label: {
                        SettingRowView(
                            imageName: "xmark.circle.fill",
                            title: "Delete Account",
                            tintColor: .red)
                    }
                }
            }
        } 
    }
}

#Preview {
    ProfileView()
}
