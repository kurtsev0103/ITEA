//
//  NetworkManager.swift
//  tEXT filter
//
//  Created by macbook pro on 12/1/19.
//  Copyright © 2019 cyb. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

public enum kHTTPMethod: String
{
    case GET, POST, PUT, PATCH, DELETE
}

public enum ErrorType: Error
{
    case noNetwork, requestSuccess, requestFailed, requestCancelled
}

public class NetworkManager
{
    
    // MARK: - Properties
    
    /**
     A shared instance of `Manager`, used by top-level Alamofire request methods, and suitable for use directly
     for any ad hoc requests.
     */
    internal static let sharedInstance: NetworkManager = {
        return NetworkManager()
    }()
    
    //MARK:- Public Method
    /**
     *  Initiates HTTPS or HTTP request over |kHTTPMethod| method and returns call back in success and failure block.
     *
     *  @param serviceName  name of the service
     *  @param method       method type like Get and Post
     *  @param postData     parameters
     *  @param responeBlock call back in block
     */
    func requestApi(serviceName: String, method: kHTTPMethod, postData: Dictionary<String, Any>, withProgressHUD showProgress: Bool, completionClosure:@escaping (_ result: Any?, _ error: Error?, _ errorType: ErrorType, _ statusCode: NSNumber?) -> ()) -> Void
    {
        if NetworkReachabilityManager()?.isReachable == true
        {
            //let headers = NetworkHelpers.shared.getHeaderWithAPIName(serviceName: serviceName)
            
            let serviceUrl = NetworkHelpers.shared.getServiceUrl(string: serviceName)
            
            let params = NetworkHelpers.shared.getPrintableParamsFromJson(postData: postData)
            
            let apiKey = ВПИСАТЬ_СВОЙ_API_КЛЮЧ_!
            let headers: HTTPHeaders = [
                "x-rapidapi-host": "api-football-v1.p.rapidapi.com",
                "x-rapidapi-key": apiKey
            ]
            
            if showProgress
            {
                NetworkHelpers.shared.showProgressHUD()
            }
            
            switch method
            {
            case .GET:
                
                AF.request(serviceUrl, method: .get, parameters: postData, encoding: URLEncoding.default, headers: headers).responseJSON(completionHandler:
                    { (DataResponse) in
                        //NetworkHelpers.shared.hideProgressHUD()
                        switch DataResponse.result
                        {
                        case .success(let JSON):
                            
                            let response = NetworkHelpers.shared.getResponseDataDictionaryFromData(data: DataResponse.data!)
                            completionClosure(response.responseData, response.error, .requestSuccess, 200)
                        case .failure(let error):
                            if error.localizedDescription == "cancelled"
                            {
                                completionClosure(nil, error, .requestCancelled, 404)
                            }
                            else
                            {
                                completionClosure(nil, error, .requestFailed, 304)
                            }
                        }
                })
            case .POST:
                AF.request(serviceUrl, method: .post, parameters: postData, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler:
                    { (DataResponse) in
                        NetworkHelpers.shared.hideProgressHUD()
                        switch DataResponse.result
                        {
                        case .success(let JSON):
                            let response = NetworkHelpers.shared.getResponseDataDictionaryFromData(data: DataResponse.data!)
                            completionClosure(response.responseData, response.error, .requestSuccess, 200)
                        case .failure(let error):
                            completionClosure(nil, error, .requestFailed, 304)
                        }
                })
            case .PUT:
                AF.request(serviceUrl, method: .put, parameters: postData, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler:
                    { (DataResponse) in
                        NetworkHelpers.shared.hideProgressHUD()
                        switch DataResponse.result
                        {
                        case .success(let JSON):
                            let response = NetworkHelpers.shared.getResponseDataDictionaryFromData(data: DataResponse.data!)
                            completionClosure(response.responseData, response.error, .requestSuccess, 200)
                        case .failure(let error):
                            completionClosure(nil, error, .requestFailed, 302)
                        }
                })
            case .PATCH:
                AF.request(serviceUrl, method: .patch, parameters: postData, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler:
                    { (DataResponse) in
                        NetworkHelpers.shared.hideProgressHUD()
                        switch DataResponse.result
                        {
                        case .success(let JSON):
                            let response = NetworkHelpers.shared.getResponseDataDictionaryFromData(data: DataResponse.data!)
                            completionClosure(response.responseData, response.error, .requestSuccess, 200)
                        case .failure(let error):
                            completionClosure(nil, error, .requestFailed, 402)
                        }
                })
            case .DELETE:
                AF.request(serviceUrl, method: .delete, parameters: postData, encoding: URLEncoding.default, headers: headers).responseJSON(completionHandler:
                    { (DataResponse) in
                        NetworkHelpers.shared.hideProgressHUD()
                        switch DataResponse.result
                        {
                        case .success(let JSON):
                            let response = NetworkHelpers.shared.getResponseDataDictionaryFromData(data: DataResponse.data!)
                            completionClosure(response.responseData, response.error, .requestSuccess, 200)
                        case .failure(let error):
                            completionClosure(nil, error, .requestFailed, 304)
                        }
                })
            }
        }
        else
        {
            //kSharedNetworkHelpers.hideProgressHUD()
            completionClosure(nil, nil, .noNetwork, nil)
        }
    }
    
    /**
     *  Upload multiple images and videos via multipart
     *
     *  @param serviceName  name of the service
     *  @param imagesArray  array having images in NSData form
     *  @param videosArray  array having videos file path
     *  @param postData     parameters
     *  @param responeBlock call back in block
     */

}

