//
//  LoginViewModal.swift
//  AuthModule
//
//  Created with ❤️ by Manpreet Singh
//

import Foundation

class LoginViewModal: ObservableObject {
   
    @Published var errorMessage         : String?
    @Published var isLoading            : Bool   = false
    @Published var isLoggedIn           : Bool   = false
    @Published var email                : String = ""
    @Published var password             : String = ""
    @Published var oldPassword          : String = ""
    @Published var newPassword          : String = ""
    @Published var confirmPassword      : String = ""
    
    func login() {
        
        self.isLoading                  = true
        if self.validateLoginFields() {
            
            let params                  = ["email": email,
                                           "password": password]
            WebServiceManager.shared.post(urlString: UrlStrings.shared.loginUrl, body: params, responseType: AuthResponse.self, completion: { result in
                
                self.isLoading          = false
                switch result {
                
                case .success(let response):
                    
                    self.errorMessage   = ""
                    self.isLoggedIn     = true
                    debugPrint("login success:", response.message)
                    
                case .failure(let error):
                    
                    self.errorMessage   = error.localizedDescription
                    debugPrint("login failed:", error.localizedDescription)
                }
            })
        }
        else {
           
            self.isLoading              = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.isLoading          = false
                self.errorMessage       = ""
            }
        }
    }
    
    func validateLoginFields() -> Bool {
        
        if email.isEmpty {
            self.errorMessage           = "Please add your email address"
            return false
        }
        else if email.isValidEmail() == false {
            self.errorMessage           = "Please add correct email address"
            return false
        }
//        else if password.count < 6 {
//            self.errorMessage           = "Password should be atleast 6 characters"
//            return false
//        }
//        else if password.isValidPassword() == false {
//            self.errorMessage           = "Password should contain at least one uppercase letter, one lowercase letter, and one digit"
//            return false
//        }
        return true
    }
    
    func forgotPassword() {
        
        self.isLoading                  = true
        if email.isValidEmail() == false {
            
            self.isLoading              = false
            self.errorMessage           = "Please add correct email address"
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                
                self.isLoading          = false
                self.errorMessage       = ""
            }
        }
        else {
            
            let params                  = ["email": email]
            WebServiceManager.shared.post(urlString: UrlStrings.shared.forgotPasswordUrl, body: params, responseType: AuthResponse.self, completion: { result in
                
                self.isLoading          = false
                switch result {
                
                case .success(let response):
                   
                    self.errorMessage   = ""
                    debugPrint("login success:", response.message)
               
                case .failure(let error):
                    
                    self.errorMessage   = error.localizedDescription
                    debugPrint("login failed:", error.localizedDescription)
                }
            })
        }
    }
    
    func changePassword() {
        
        self.isLoading                  = true
        if oldPassword.isValidPassword() == false {
            self.errorMessage           = "Password should contain at least one uppercase letter, one lowercase letter, and one digit"
            self.isLoading              = false
        }
        else if newPassword.isValidPassword() == false {
            self.errorMessage           = "Password should contain at least one uppercase letter, one lowercase letter, and one digit"
            self.isLoading              = false
        }
        else if confirmPassword.isValidPassword() == false {
            self.errorMessage           = "Password should contain at least one uppercase letter, one lowercase letter, and one digit"
            self.isLoading              = false
        }
        else if confirmPassword != newPassword {
            self.errorMessage           = "Passwords do not match"
            self.isLoading              = false
        }
        else {
            
            let params                  = ["oldPassword": oldPassword,
                                           "newPassword": newPassword,
                                           "confirmPassword": confirmPassword]
            WebServiceManager.shared.post(urlString: UrlStrings.shared.changePasswordUrl, body: params, responseType: AuthResponse.self) { result in
               
                self.isLoading          = false
                switch result {
                
                case .success(let response):
                   
                    self.errorMessage   = ""
                    debugPrint("login success:", response.message)
               
                case .failure(let error):
                    
                    self.errorMessage   = error.localizedDescription
                    debugPrint("login failed:", error.localizedDescription)
                }
            }
        }
    }
}
