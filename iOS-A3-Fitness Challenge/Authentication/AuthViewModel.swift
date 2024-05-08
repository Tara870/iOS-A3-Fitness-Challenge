//
//  AuthViewModel.swift
//  iOS-A3-Fitness Challenge
//
//  Created by Tara Jiang on 8/5/2024.
//

import Foundation
import Firebase

class AuthViewModel: ObservableObject {
    @Published var userSession : FirebaseAuth.User?
    @Published var currentUser : User?
    @Published var hi : String = "HI"
    
    init() {
        
    }
    
    func signIn(withEmail email : String, password : String) async throws {
        print("Sign In")
    }
    
    func createUser(withEmail email : String, password : String, fullName : String) async throws{
        print("Create User")
    }
    
    func deleteUser() {
        
    }
    
    func fetchUser() async {
        
    }
}
