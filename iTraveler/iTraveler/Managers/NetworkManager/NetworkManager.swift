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
    
    func requestApi(stringURL: String, method: HTTPMethod, parameters: Parameters? = nil, completion: @escaping (Result<Data?, Error>) -> Void) {
        
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
    func callOCRSpace(image: UIImage?, completion: @escaping (Result<String, Error>) -> Void) {
        // Create URL request
        let url = URL(string: "https://api.ocr.space/Parse/Image")
        var request: URLRequest? = nil
        if let url = url {
            request = URLRequest(url: url)
        }
        request?.httpMethod = "POST"
        let boundary = "randomString"
        request?.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        
        // Image file and parameters
        let imageData = image?.jpegData(compressionQuality: 0.6)
        let parametersDictionary = ["apikey" : "d30c014ee888957", "isOverlayRequired" : "True"]

        // Create multipart form body
        let data = createBody(withBoundary: boundary, parameters: parametersDictionary, imageData: imageData, filename: "yourImage.jpg")

        request?.httpBody = data

        // Start data session
        var task: URLSessionDataTask? = nil
        if let request = request {
            task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                var result: [AnyHashable : Any]? = nil
                do {
                    if let data = data {
                        result = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                    }
                } catch {
                    completion(.failure(error))
                }
                                
                if let result = result {
                    let array = result["ParsedResults"] as? [Any]
                    guard let dict = array?.first as? [String: Any] else { return }
                    guard let text = dict["ParsedText"] as? String else { return }

                    completion(.success(text))
                }
                                
            })
        }
        task?.resume()
    }

    func createBody(withBoundary boundary: String?, parameters: [AnyHashable : Any]?, imageData data: Data?, filename: String?) -> Data? {
        var body = Data()
        if data != nil {
            if let data1 = "--\(boundary ?? "")\r\n".data(using: .utf8) {
                body.append(data1)
            }
            if let data1 = "Content-Disposition: form-data; name=\"\("file")\"; filename=\"\(filename ?? "")\"\r\n".data(using: .utf8) {
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

        for key in parameters!.keys {
            if let data1 = "--\(boundary ?? "")\r\n".data(using: .utf8) {
                body.append(data1)
            }
            if let data1 = "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8) {
                body.append(data1)
            }
            if let parameter = parameters?[key], let data1 = "\(parameter)\r\n".data(using: .utf8) {
                body.append(data1)
            }
        }

        if let data1 = "--\(boundary ?? "")--\r\n".data(using: .utf8) {
            body.append(data1)
        }
        return body
    }
}
