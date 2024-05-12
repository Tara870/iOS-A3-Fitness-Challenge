//
//  RegisterView.swift
//  iOS-A3-Fitness Challenge
//
//  Created by Tara Jiang on 7/5/2024.
//

import SwiftUI

struct RegisterView: View {
    @State private var email = ""
    @State private var fullName = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authViewModel : AuthViewModel
    
    var body: some View {
        VStack {
            // logo image
            Image("logo")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 120)
                .padding(.vertical, 32)
            
            // form fields
            // call reusable view
            VStack(spacing: 24) {
                InputView(text: $email, 
                          title: "Email Address",
                          placeholder: "name@example.com")
                    .autocapitalization(.none)
                
                InputView(text: $fullName,
                          title: "Full Name",
                          placeholder: "Enter your name")
                    .autocapitalization(.none)
                
                InputView(text: $password, 
                          title: "Password (at least 6 characters)",
                          placeholder: "Enter your password",
                          isSecureField: true)
                
//                InputView(text: $confirmPassword, 
//                          title: "Confirm Your Password",
//                          placeholder: "Re-enter your password",
//                          isSecureField: true)
                
                ZStack(alignment: .trailing) {
                    InputView(text: $confirmPassword,
                              title: "Confirm Your Password",
                              placeholder: "Re-enter your password",
                              isSecureField: true)
                    
                    if !password.isEmpty && !confirmPassword.isEmpty {
                        if password == confirmPassword {
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemGreen))
                        } else {
                            Image(systemName: "xmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemRed))
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            // sign in button
            Button {
                Task {
                    // call sign in function under viewModel
                    try await authViewModel.createUser(
                        withEmail: email,
                        password: password,
                        fullName: fullName)
                }
            } label: {
                HStack {
                    Text("SIGN UP")
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                }
                .foregroundColor(.white)
                .frame(width:UIScreen.main.bounds.width-32, height: 48)
            }
            .background(Color(.systemBlue))
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0 : 0.5)
            .cornerRadius(10)
            .padding(.top, 24)
             
            Spacer()
            
            Button {
                // return to the previous view 
                dismiss()
            } label: {
                HStack{
                    Text("Already have an account?")
                    Text("Sign In")
                        .fontWeight(.bold)
                }
                .font(.system(size: 14))
            }
        }
    }
}

extension RegisterView: ValidationFromProtocol {
    // email.isEmpty returns false if email is not empty
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && confirmPassword == password
        && !fullName.isEmpty
    }
}

#Preview {
    RegisterView()
}
