//
//  SignUpViewModal.swift
//  AuthModule
//
//  Created with ❤️ by Manpreet Singh
//

import Foundation

class SignUpViewModal: ObservableObject {
    
    @Published var errorMessage         : String?
    @Published var isLoading            : Bool   = false
    @Published var fullName             : String = ""
    @Published var email                : String = ""
    @Published var password             : String = ""
    @Published var confirmPassword      : String = ""
    
    
    func signUp() {
       
        isLoading                       = true
        if validateFields() {
            
            let params                  = ["email": email,
                                           "password": password,
                                           "name": fullName]
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
        else {
            
            self.isLoading              = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                
                self.errorMessage       = ""
            }
        }
    }
    
    func validateFields() -> Bool {
       
        if fullName.isEmpty {
            errorMessage                = "Full name is required"
            return false
        }
        else if fullName.count < 3 {
            errorMessage                = "Full name should be at least 3 characters long"
            return false
        }
        else if email.isValidEmail() == false {
            errorMessage                = "Invalid email format"
            return false
        }
        else if password.isEmpty {
            errorMessage                = "Password is required"
            return false
        }
        else if password.count < 6 {
            errorMessage                = "Password should be at least 6 characters long"
        }
        else if password.isValidPassword() == false {
            errorMessage                = "Password should contain at least one uppercase letter, one lowercase letter, and one digit"
            return false
        }
        else if confirmPassword.isEmpty {
            errorMessage                = "Confirm password is required"
            return false
        }
        else if confirmPassword != password {
            errorMessage                = "Passwords do not match"
            return false
        }
        return true
    }
}
