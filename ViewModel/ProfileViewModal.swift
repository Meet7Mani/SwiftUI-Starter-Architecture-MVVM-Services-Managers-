//
//  ProfileViewModal.swift
//  AuthModule
//
//  Created with ❤️ by Manpreet Singhon 04/06/25.
//

import Foundation
import UIKit

class ProfileViewModal : ObservableObject {
    
    @Published var firstName            : String = ""
    @Published var lastName             : String = ""
    @Published var phoneNumber          : String = ""
    @Published var location             : String = ""
    @Published var aboutMe              : String = ""
    @Published var profileImage         : UIImage?
    @Published var errorMessage         : String?
    @Published var isLoading            : Bool   = false
        
    func updateProfileData() {
        
        self.isLoading                  = true
        if self.validateLoginFields() {
            
            let params                  = ["firstName"  : firstName,
                                           "lastName"   : lastName,
                                           "phoneNumber": phoneNumber,
                                           "location"   : location,
                                           "aboutMe"    : aboutMe]
            guard let imageData = profileImage?.jpegData(compressionQuality: 0.8) else {
                return
            }
            WebServiceManager.shared.postMultipartMethod(urlString: UrlStrings.shared.userUrl, body: params, image: imageData, responseType: AuthResponse.self) { result in
                
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
        else {
           
            self.isLoading              = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.isLoading          = false
                self.errorMessage       = ""
            }
        }
    }
    
    func getProfileData() {
       
        self.isLoading                  = true
        WebServiceManager.shared.getMethod(urlString: UrlStrings.shared.userUrl, responseType: AuthResponse.self) { result in
            
            self.isLoading              = false
            switch result {
            
            case .success(let response):
                
                self.errorMessage       = ""
                let userData            = response.user
                
                userData?.profileImageURL?.downloadImage(completion: { img in
                    
                    self.profileImage   = img
                })
                self.profileImage       = userData?.profileImageURL.flatMap(UIImage.init(named:))
                self.firstName          = userData?.firstName   ?? ""
                self.lastName           = userData?.lastName    ?? ""
                self.phoneNumber        = userData?.phone       ?? ""
                self.aboutMe            = userData?.aboutMe     ?? ""
                debugPrint("login success:", response.message)
                
            case .failure(let error):
                
                self.errorMessage       = error.localizedDescription
                debugPrint("login failed:", error.localizedDescription)
            }
        }
    }
    
    func validateLoginFields() -> Bool {
        
        if firstName.isEmpty {
            self.errorMessage           = "Please add first name"
            return false
        }
        else if lastName.isEmpty {
            self.errorMessage           = "Please add last name"
            return false
        }
        else if phoneNumber.isEmpty {
            self.errorMessage           = "Please add phone number"
            return false
        }
        else if phoneNumber.isValidPhone() == false {
            self.errorMessage           = "Please add valid phone number"
            return false
        }
        else if location.isEmpty {
            self.errorMessage           = "Please add location"
            return false
        }
        return true
    }
}
