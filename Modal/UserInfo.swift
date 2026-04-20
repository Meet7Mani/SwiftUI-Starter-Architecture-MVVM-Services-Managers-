//
//  UserInfo.swift
//  AuthModule
//
//  Created with ❤️ by Manpreet Singh
//

import Foundation

struct UserInfo: Codable {
    
    let id              : String
    let name            : String
    let firstName       : String
    let lastName        : String
    let aboutMe         : String
    let phone           : String?
    let profileImageURL : String?
}
