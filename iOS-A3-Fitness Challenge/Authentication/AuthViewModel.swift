//
//  AuthViewModel.swift
//  iOS-A3-Fitness Challenge
//
//  Created by Tara Jiang on 8/5/2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

@MainActor // publish all UI changes back to main thread
class AuthViewModel: ObservableObject {
    @Published var userSession : FirebaseAuth.User? // firebase user object
    @Published var currentUser : User?
    
    init() {
        // check if there is a local user logged in
        // show landing view
        self.userSession = Auth.auth().currentUser
        
        Task {
            await fetchUser()
        }
    }
    
    func signIn(withEmail email : String, password : String) async throws {
        print("Sign In")
    }
    
    func createUser(withEmail email : String, password : String, fullName : String) async throws{
        do {
            // wait for result - creating a user with firebase
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user // set user session
            let user = User(id: result.user.uid, fullName: fullName, email: email) // customised user object
            // encode user to raw data and push to firebase
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser) // uplode the user to firestore
        } catch {
            print("Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut() // sign the user out from backend
            self.userSession = nil // remove userSession take the user to the login view
            self.currentUser = nil
        } catch {
            print("Failed to create user with error \(error.localizedDescription)")
        }
        
    }
    
    func deleteUser() {
        
    }
    
    func fetchUser() async {
        // if there is a user loggin in
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        guard let snapshot = try? await  Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        
        self.currentUser = try? snapshot.data(as: User.self)
    }
}
