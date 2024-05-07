//
//  InputView.swift
//  iOS-A3-Fitness Challenge
//
//  Created by Tara Jiang on 7/5/2024.
//

import SwiftUI

// for login and register
// reusable code
// title with a input field

struct InputView: View {
    @Binding var text : String
    let title : String
    let placeholder : String
    var isSecureField = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .foregroundColor(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.footnote)
            
            // password * / normal text
            if isSecureField {
                SecureField(placeholder, text: $text)
                    .font(.system(size: 14))
            }
            else {
                TextField(placeholder, text: $text)
                    .font(.system(size: 14))
            }
            
            Divider()
        }
        
        
    }
}

#Preview {
    InputView(text: .constant(""), title: "Email Address", placeholder: "name@example.com")
}
