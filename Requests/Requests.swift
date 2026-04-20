//
//  Requests.swift
//  AuthModule
//
//  Created with ❤️ by Manpreet Singh
//

import Foundation

struct SignupRequest: Codable {
    
    let email           : String
    let password        : String
    let name            : String
}

struct LoginRequest: Codable {
    
    let email           : String
    let password        : String
}
struct ForgotPasswordRequest: Codable {
    
    let email           : String
}
struct ChangePasswordRequest: Codable {
    
    let oldPassword     : String
    let newPassword     : String
    let confirmPassword : String
}
