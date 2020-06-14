//
//  NetworkManager.swift
//  ITEA_14
//
//  Created by Oleksandr Kurtsev on 12/06/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import Foundation
import Alamofire

public enum HTTPMethod: String {
    case GET, POST, PUT, PATCH, DELETE
}

public enum ResponseType {
    case success, failed, cancelled, noNetwork
}

class NetworkManager {
    
    // MARK: - Properties

    static let shared = NetworkManager()
    
    // MARK: - Public Method
    
    func requestApi(stringURL: String, method: HTTPMethod, parameters: Parameters, completion: @escaping (_ result: Any?, _ error: Error?, _ responseType: ResponseType) -> ()) {
        
        guard NetworkReachabilityManager()?.isReachable == true else {
            completion(nil, nil, .noNetwork)
            return
        }
        
        let url = sharedNetworkHelpers.getUrlFromString(stringURL: stringURL)
        let headers = sharedNetworkHelpers.getHeaderWithAPIName(stringURL: stringURL)
        let params = sharedNetworkHelpers.getParamsFromJSON(parameters: parameters)

        switch method {
            
        case .GET:
            
            AF.request(url, method: .get, parameters: params, headers: headers).responseJSON { (response) in
                switch response.result {
                case .success(_):
                    let response = sharedNetworkHelpers.getResponseDataDictionaryFromData(data: response.data!)
                    completion(response.dictData, nil, .success)
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    if error.localizedDescription == "cancelled" {
                        completion(nil, error, .cancelled)
                    } else {
                        completion(nil, error, .failed)
                    }
                }
            }

        case .POST:
            
            AF.request(url, method: .post, parameters: params, headers: headers).responseJSON { (response) in
                switch response.result {
                case .success(_):
                    let response = sharedNetworkHelpers.getResponseDataDictionaryFromData(data: response.data!)
                    completion(response.dictData, nil, .success)
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    completion(nil, error, .failed)
                }
            }
            
        case .PUT:
            
            AF.request(url, method: .put, parameters: params, headers: headers).responseJSON { (response) in
                switch response.result {
                case .success(_):
                    let response = sharedNetworkHelpers.getResponseDataDictionaryFromData(data: response.data!)
                    completion(response.dictData, nil, .success)
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    completion(nil, error, .failed)
                }
            }
            
        case .PATCH:
            
            AF.request(url, method: .patch, parameters: params, headers: headers).responseJSON { (response) in
                switch response.result {
                case .success(_):
                    let response = sharedNetworkHelpers.getResponseDataDictionaryFromData(data: response.data!)
                    completion(response.dictData, nil, .success)
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    completion(nil, error, .failed)
                }
            }
            
        case .DELETE:
            
            AF.request(url, method: .delete, parameters: params, headers: headers).responseJSON { (response) in
                switch response.result {
                case .success(_):
                    let response = sharedNetworkHelpers.getResponseDataDictionaryFromData(data: response.data!)
                    completion(response.dictData, nil, .success)
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    completion(nil, error, .failed)
                }
            }
        }
    }
    
    func cancelAllRequests(completionHandler: @escaping () -> ()) {
        AF.session.getTasksWithCompletionHandler { (dataTask: [URLSessionDataTask], uploadTask: [URLSessionUploadTask], downloadTask: [URLSessionDownloadTask]) in
            dataTask.forEach({ (task: URLSessionDataTask) in task.cancel() })
            uploadTask.forEach({ (task: URLSessionUploadTask) in task.cancel() })
            downloadTask.forEach({ (task: URLSessionDownloadTask) in task.cancel() })
            completionHandler()
        }
    }
}
