//
//  UrlStrings.swift
//  AuthModule
//
//  Created with ❤️ by Manpreet Singh
//

import Foundation

class UrlStrings {
    
    static let shared       = UrlStrings()
    ///Auth Urls
    let baseUrl             : String = "http://"
    let loginUrl            : String = "login"
    let signOutUrl          : String = "/logout"
    let signUpUrl           : String = "register"
    let forgotPasswordUrl   : String = "create"
    let changePasswordUrl   : String = "changePassword"
    let userUrl             : String = "/user"
}
