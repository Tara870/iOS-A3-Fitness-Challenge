//
//  AuthViewModel.swift
//  iOS-A3-Fitness Challenge
//
//  Created by Tara Jiang on 8/5/2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol ValidationFromProtocol {
    var formIsValid: Bool { get }
}

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
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            print("Failed to create user with error \(error.localizedDescription)")
        }
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
            await fetchUser()
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
    
    func deleteUser() async throws {
        do {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            try await Firestore.firestore().collection("users").document(uid).delete()
            try await Auth.auth().currentUser?.delete()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("Failed to delete user with error: \(error.localizedDescription)")
        }
    }
    
    func fetchUser() async {
        // if there is a user loggin in
        guard let uid = Auth.auth().currentUser?.uid else { return }
        print("fetch")
        print(uid)
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
        print("DEBUG: CUrrent User is \(self.currentUser)")
    }
}
