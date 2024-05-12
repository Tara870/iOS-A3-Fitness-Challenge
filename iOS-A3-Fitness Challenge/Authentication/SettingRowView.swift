//
//  SettingRowView.swift
//  iOS-A3-Fitness Challenge
//
//  Created by Tara Jiang on 8/5/2024.
//

import SwiftUI

struct SettingRowView: View {
    let imageName : String
    let title : String
    let tintColor : Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: imageName)
                .imageScale(.small)
                .font(.title)
                .foregroundColor(tintColor)
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(.black)
        }
    }
}

#Preview {
    SettingRowView(imageName : "gear", 
                   title : "Version",
                   tintColor : Color(.systemGray))
}
