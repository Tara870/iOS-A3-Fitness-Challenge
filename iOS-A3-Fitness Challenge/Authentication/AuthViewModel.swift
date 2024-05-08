//
//  AuthViewModel.swift
//  iOS-A3-Fitness Challenge
//
//  Created by Tara Jiang on 8/5/2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class AuthViewModel: ObservableObject {
    @Published var userSession : FirebaseAuth.User? // firebase user object
    @Published var currentUser : User?
    
    init() {
        
    }
    
    func signIn(withEmail email : String, password : String) async throws {
        print("Sign In")
    }
    
    func createUser(withEmail email : String, password : String, fullName : String) async throws{
        do {
            // wait for user's result
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullName: fullName, email: email) // customised user class
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
        } catch {
            print("Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func deleteUser() {
        
    }
    
    func fetchUser() async {
        
    }
}
