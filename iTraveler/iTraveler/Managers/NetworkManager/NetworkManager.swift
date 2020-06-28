//
//  NetworkManager.swift
//  iTraveler
//
//  Created by Oleksandr Kurtsev on 17/06/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    // MARK: - Properties
    
    static let shared = NetworkManager()
    private let sharedNetworkHelpers = NetworkHelpers.shared
    private init() {}
    
    // MARK: - Methods
    
    func requestApi(stringURL: String, method: HTTPMethod, headers: HTTPHeaders? = nil, parameters: Parameters? = nil, completion: @escaping (Result<Data?, Error>) -> Void) {
        
        guard NetworkReachabilityManager()?.isReachable == true else {
            completion(.failure(NetworkError.noNetwork))
            return
        }
        
        let url = sharedNetworkHelpers.getUrlFromString(stringURL: stringURL)
        let headers = sharedNetworkHelpers.getHeaderWithAPIName()
        
        switch method {
            
        case .GET:
            
            AF.request(url, method: .get, parameters: parameters, headers: headers).responseJSON { (response) in
                switch response.result {
                case .success(_):
                    completion(.success(response.data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            
        case .POST:
            
            AF.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in
                switch response.result {
                case .success(_):
                    completion(.success(response.data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            
        case .PUT:
            
            AF.request(url, method: .put, parameters: parameters, headers: headers).responseJSON { (response) in
                switch response.result {
                case .success(_):
                    completion(.success(response.data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            
        case .PATCH:
            
            AF.request(url, method: .patch, parameters: parameters, headers: headers).responseJSON { (response) in
                switch response.result {
                case .success(_):
                    completion(.success(response.data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            
        case .DELETE:
            
            AF.request(url, method: .delete, parameters: parameters, headers: headers).responseJSON { (response) in
                switch response.result {
                case .success(_):
                    completion(.success(response.data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } //switch method
    } //requestApi
}

// MARK: - API request to get text from image
extension NetworkManager {
    
    func convertImageToText(image: UIImage?, completion: @escaping (Result<String, Error>) -> Void) {
        let imageData = image?.jpegData(compressionQuality: 0.6)
        let boundary = UUID().uuidString
        
        let parameters: Parameters = ["apikey": "d30c014ee888957",
                                      "isOverlayRequired": "True"]
        
        guard let url = URL(string: "https://api.ocr.space/Parse/Image") else { return }
        let data = createBodyWith(boundary: boundary, parameters: parameters, data: imageData)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = data
        
        AF.request(request).responseJSON { (response) in
            switch response.result {
            case .success(_):
                guard let data = response.data else { return }
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
                        guard let array = json["ParsedResults"] as? [Any]           else { return }
                        guard let dict  = array.first           as? [String: Any]   else { return }
                        guard let text  = dict["ParsedText"]    as? String          else { return }
                        
                        completion(.success(text))
                    }
                } catch {
                    completion(.failure(error))
                }

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func createBodyWith(boundary: String, parameters: Parameters, data: Data?) -> Data? {
        var body = Data()
        
        if data != nil {
            if let data1 = "--\(boundary)\r\n".data(using: .utf8) {
                body.append(data1)
            }
            if let data1 = "Content-Disposition: form-data; name=\"\("file")\"; filename=\"image.jpeg\"\r\n".data(using: .utf8) {
                body.append(data1)
            }
            if let data1 = "Content-Type: image/jpeg\r\n\r\n".data(using: .utf8) {
                body.append(data1)
            }
            if let data = data {
                body.append(data)
            }
            if let data1 = "\r\n".data(using: .utf8) {
                body.append(data1)
            }
        }
        
        for key in parameters.keys {
            if let data1 = "--\(boundary)\r\n".data(using: .utf8) {
                body.append(data1)
            }
            if let data1 = "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8) {
                body.append(data1)
            }
            if let parameter = parameters[key], let data1 = "\(parameter)\r\n".data(using: .utf8) {
                body.append(data1)
            }
        }
        
        if let data1 = "--\(boundary)--\r\n".data(using: .utf8) {
            body.append(data1)
        }
        
        return body
    }
}

