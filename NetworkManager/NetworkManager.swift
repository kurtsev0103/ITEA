//
//  NetworkManager.swift
//  NetworkManager
//
//  Created by Oleksandr Kurtsev on 12/06/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

public enum kHTTPMethod: String {
    case GET, POST, PUT, PATCH, DELETE
}

public enum ErrorType: Error {
    case noNetwork, requestSuccess, requestFailed, requestCancelled
}

public class NetworkManager {
    
    // MARK: - Properties

    internal static let sharedInstance: NetworkManager = {
        return NetworkManager()
    }()
    
    // MARK: - Public Method

    func requestApi(serviceName: String, method: kHTTPMethod, postData: Dictionary<String, Any>, withProgressHUD showProgress: Bool, completionClosure:@escaping (_ result: Any?, _ error: Error?, _ errorType: ErrorType, _ statusCode: Int?) -> ()) -> Void {
        
        if NetworkReachabilityManager()?.isReachable == true {
            
            let headers = kSharedNetworkHelpers.getHeaderWithAPIName(serviceName: serviceName)
            let serviceUrl = kSharedNetworkHelpers.getServiceUrl(string: serviceName)
            let params = kSharedNetworkHelpers.getPrintableParamsFromJson(postData: postData)
            
            debugPrint("Connecting to Host with URL \(serviceName) with parameters: \(params)")
            
            //NSAssert Statements
            assert(method != .GET || method != .POST, "kHTTPMethod should be one of kHTTPMethodGET|kHTTPMethodPOST|kHTTPMethodPOSTMultiPart.");
            
            if showProgress {
                //kSharedNetworkHelpers.showProgressHUD()
            }
            
            switch method {
            case .GET:
                
                AF.request(serviceUrl, method: .get, parameters: postData, encoding: URLEncoding.default, headers: headers).responseJSON(completionHandler:
                    { (DataResponse) in
                        
                        //kSharedNetworkHelpers.hideProgressHUD()
                        switch DataResponse.result {
                            
                        case .success(let JSON):
                            debugPrint("Success with JSON: \(JSON)")
                            debugPrint("Success with status Code: \(String(describing: DataResponse.response?.statusCode))")
                            
                            let response = kSharedNetworkHelpers.getResponseDataDictionaryFromData(data: DataResponse.data!)
                            completionClosure(response.responseData, response.error, .requestSuccess, DataResponse.response?.statusCode)
                            
                        case .failure(let error):
                            debugPrint("json error: \(error.localizedDescription)")
                            if error.localizedDescription == "cancelled" {
                                completionClosure(nil, error, .requestCancelled, DataResponse.response?.statusCode)
                            } else {
                                completionClosure(nil, error, .requestFailed, DataResponse.response?.statusCode)
                            }
                        }
                })
                
            case .POST:
                
                AF.request(serviceUrl, method: .post, parameters: postData, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler:
                    { (DataResponse) in
                        
                        kSharedNetworkHelpers.hideProgressHUD()
                        switch DataResponse.result {
                            
                        case .success(let JSON):
                            debugPrint("Success with JSON: \(JSON)")
                            debugPrint("Success with status Code: \(String(describing: DataResponse.response?.statusCode))")
                            let response = kSharedNetworkHelpers.getResponseDataDictionaryFromData(data: DataResponse.data!)
                            completionClosure(response.responseData, response.error, .requestSuccess, DataResponse.response?.statusCode)
                            
                        case .failure(let error):
                            debugPrint("json error: \(error.localizedDescription)")
                            completionClosure(nil, error, .requestFailed, DataResponse.response?.statusCode)
                        }
                })
                
            case .PUT:
                
                AF.request(serviceUrl, method: .put, parameters: postData, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler:
                    { (DataResponse) in
                        
                        kSharedNetworkHelpers.hideProgressHUD()
                        switch DataResponse.result {
                            
                        case .success(let JSON):
                            debugPrint("Success with JSON: \(JSON)")
                            debugPrint("Success with status Code: \(String(describing: DataResponse.response?.statusCode))")
                            let response = kSharedNetworkHelpers.getResponseDataDictionaryFromData(data: DataResponse.data!)
                            completionClosure(response.responseData, response.error, .requestSuccess, DataResponse.response?.statusCode)
                            
                        case .failure(let error):
                            debugPrint("json error: \(error.localizedDescription)")
                            completionClosure(nil, error, .requestFailed, DataResponse.response?.statusCode)
                        }
                })
                
            case .PATCH:
                
                AF.request(serviceUrl, method: .patch, parameters: postData, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler:
                    { (DataResponse) in
                        
                        kSharedNetworkHelpers.hideProgressHUD()
                        switch DataResponse.result {
                            
                        case .success(let JSON):
                            debugPrint("Success with JSON: \(JSON)")
                            debugPrint("Success with status Code: \(String(describing: DataResponse.response?.statusCode))")
                            let response = kSharedNetworkHelpers.getResponseDataDictionaryFromData(data: DataResponse.data!)
                            completionClosure(response.responseData, response.error, .requestSuccess, DataResponse.response?.statusCode)
                            
                        case .failure(let error):
                            debugPrint("json error: \(error.localizedDescription)")
                            completionClosure(nil, error, .requestFailed, DataResponse.response?.statusCode)
                        }
                })
                
            case .DELETE:
                
                AF.request(serviceUrl, method: .delete, parameters: postData, encoding: URLEncoding.default, headers: headers).responseJSON(completionHandler:
                    { (DataResponse) in
                        
                        kSharedNetworkHelpers.hideProgressHUD()
                        switch DataResponse.result {
                            
                        case .success(let JSON):
                            debugPrint("Success with JSON: \(JSON)")
                            debugPrint("Success with status Code: \(String(describing: DataResponse.response?.statusCode))")
                            let response = kSharedNetworkHelpers.getResponseDataDictionaryFromData(data: DataResponse.data!)
                            completionClosure(response.responseData, response.error, .requestSuccess, DataResponse.response?.statusCode)
                            
                        case .failure(let error):
                            debugPrint("json error: \(error.localizedDescription)")
                            completionClosure(nil, error, .requestFailed, DataResponse.response?.statusCode)
                        }
                })
            }
        } else {
            kSharedNetworkHelpers.hideProgressHUD()
            completionClosure(nil, nil, .noNetwork, nil)
        }
    }
    
    func cancelAllRequests(completionHandler: @escaping () -> ())
    {
        let sessionManager = AF.session
        sessionManager.getTasksWithCompletionHandler { (dataTask: [URLSessionDataTask], uploadTask: [URLSessionUploadTask], downloadTask: [URLSessionDownloadTask]) in
            dataTask.forEach({ (task: URLSessionDataTask) in task.cancel() })
            uploadTask.forEach({ (task: URLSessionUploadTask) in task.cancel() })
            downloadTask.forEach({ (task: URLSessionDownloadTask) in task.cancel() })
            completionHandler()
        }
    }
    
}
