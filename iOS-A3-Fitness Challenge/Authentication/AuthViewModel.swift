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
    @Published var currentUSer : User?
    
    init() {
        
    }
    
    func signIn(withEmail email : String, password : String) async throws {
        
    }
    
    func createUser(withEmail email : String, password : String, fullName : String) async throws{
        
    }
    
    func deleteUser() {
        
    }
    
    func fetchUser() async {
        
    }
}
