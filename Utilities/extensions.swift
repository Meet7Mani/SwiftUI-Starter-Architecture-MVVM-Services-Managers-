//
//  extensions.swift
//  AuthModule
//
//  Created with ❤️ by Manpreet Singh
//

import Foundation
import UIKit
import Alamofire
///Common Used Regex
extension String {
    
    func isValidPassword() -> Bool {
       
        let regex               = "^(?=.*[A-Z])(?=.*[!@#$&*._\\-])[A-Za-z\\d!@#$&*._\\-]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
    }
    func isValidEmail() -> Bool {
        let regex               = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
    }
    func isValidPhone() -> Bool {
        let regex               = "^[0-9]{10}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
    }
    
    func downloadImage(completion: @escaping (UIImage?) -> Void){
        
        if let url = URL(string: self) {
           
            AF.request(url).validate().responseData { response in
               
                switch response.result {
                case .success(let data):
                   
                    let image   = UIImage(data: data)
                    completion(image)
                case .failure(let error):
                    
                    print("❌ Image download failed: \(error.localizedDescription)")
                    completion(nil)
                }
            }
        }
    }
}
