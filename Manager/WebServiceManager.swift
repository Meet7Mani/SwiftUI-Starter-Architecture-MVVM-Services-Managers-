//
//  WebServiceManager.swift
//  AuthModule
//
//  Created with ❤️ by Manpreet Singh
//

import Foundation
import Alamofire

typealias JSON                          = [String: Any]

class WebServiceManager {
   
    static let shared                   = WebServiceManager()

    private init() {}
    
    func getMethod<U: Codable>(urlString: String, responseType: U.Type, completion: @escaping (Result<U, AFError>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(AFError.invalidURL(url: URL(string: urlString)!)))
            return
        }
        
        AF.request(url).responseDecodable(of: U.self) { response in
            
            DispatchQueue.main.async {
                
                if let error = response.error {
                    
                    completion(.failure(error))
                    return
                }
                guard let data = response.value else {
                    
                    return
                }
                completion(.success(data))
            }
        }
    }

    func post<U: Codable>(urlString: String, body: JSON, responseType: U.Type, completion: @escaping (Result<U, AFError>) -> Void) {
       
        guard let url = URL(string: urlString) else {
            
            completion(.failure(AFError.invalidURL(url: URL(string: urlString)!)))
            return
        }
        
        AF.request(url, method: .post, parameters: body).responseDecodable(of: U.self) { response in
            
            DispatchQueue.main.async {
                
                if let error = response.error {
                    
                    completion(.failure(error))
                    return
                }
                guard let data = response.value else {
                    
                    return
                }
                completion(.success(data))
            }
        }
    }
    
    func postMultipartMethod<U: Codable>(urlString: String, body: JSON,image:Data, responseType: U.Type, completion: @escaping (Result<U, AFError>) -> Void) {
       
        guard let url = URL(string: urlString) else {
            
            completion(.failure(AFError.invalidURL(url: URL(string: urlString)!)))
            return
        }
        
        let headers: HTTPHeaders        = ["Authorization": "Bearer ",
                                           "Content-type": "multipart/form-data"]
        
        AF.upload(multipartFormData: { multipartFormData in
            
            // Add image
            multipartFormData.append(image, withName: "profile_image", fileName: "profile.jpg", mimeType: "image/jpeg")
            
            // Add other params
            for (key, value) in body {
                if let val = value as? String, let data = val.data(using: .utf8) {
                    
                    multipartFormData.append(data, withName: key)
                }
            }
        },to: url,method: .post,headers: headers).responseDecodable(of: U.self) { response in
            
            DispatchQueue.main.async {
                
                if let error = response.error {
                    
                    completion(.failure(error))
                    return
                }
                guard let data = response.value else {
                    
                    return
                }
                completion(.success(data))
            }
        }
    }
    
    
}

