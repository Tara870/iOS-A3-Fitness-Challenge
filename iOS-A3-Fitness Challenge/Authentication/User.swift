//
//  User.swift
//  iOS-A3-Fitness Challenge
//
//  Created by Tara Jiang on 8/5/2024.
//

import Foundation

struct User: Identifiable, Codable {
    let id : String
    let fullName : String
    let email : String
    
    // get full name initials
    var initials : String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullName) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        
        return ""
    }
}


// a mock user for testing firebase and profile view only
extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, fullName: "Alice Thomas", email: "alice.thomas@test.com")
}
