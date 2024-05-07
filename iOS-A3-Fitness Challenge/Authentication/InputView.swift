//
//  InputView.swift
//  iOS-A3-Fitness Challenge
//
//  Created by Tara Jiang on 7/5/2024.
//

import SwiftUI

struct InputView: View {
    @Binding var text : String
    let title : String
    let placeholder : String
    var isSecureField = false
    
    var body: some View {
        VStack {
            
        }
        
        
    }
}

#Preview {
    InputView(text: .constant(""), title: "Email Address", placeholder: "name@example.com")
}
