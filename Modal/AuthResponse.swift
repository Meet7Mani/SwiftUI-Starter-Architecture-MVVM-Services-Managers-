//
//  AuthResponse.swift
//  AuthModule
//
//  Created with ❤️ by Manpreet Singh
//

import Foundation

struct AuthResponse: Codable {
   
    let success         : Bool
    let message         : String
    let token           : String?
    let user            : UserInfo?         // Optional user model
}
