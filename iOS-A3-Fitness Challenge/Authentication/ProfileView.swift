//
//  ProfileView.swift
//  iOS-A3-Fitness Challenge
//
//  Created by Tara Jiang on 8/5/2024.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        List {
            Section {
                HStack {
                    Text("TJ")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 72, height: 72)
                        .background(Color(.systemGray3))
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Tara Jiang")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding(.top, 4)
                        
                        Text("test@gmail.com")
                            .font(.footnote)
                            .accentColor(.gray)
                        // email color default to blue
                        // to override the colour - accentColor
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
                    print("Sign out...")
                } label: {
                    SettingRowView(
                        imageName: "arrow.left.circle.fill",
                        title: "Sign Out",
                        tintColor: .red)
                }
                
                Button {
                    print("Delete account...")
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

#Preview {
    ProfileView()
}
