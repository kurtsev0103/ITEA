//
//  NetworkHelpers.swift
//  NetworkHelpers
//
//  Created by Oleksandr Kurtsev on 12/06/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import Foundation
import SVProgressHUD
import Alamofire

class NetworkHelpers: NSObject {
    
    private static var _manager: NetworkHelpers?
    
    static var shared: NetworkHelpers {
        get {
            if _manager == nil {
                _manager = NetworkHelpers()
            }
            return _manager!
        }
        set {
            _manager = newValue
        }
    }
    
    // MARK: - Private Method
    
    func showProgressHUD() {
        SVProgressHUD.show(withStatus: "Please Wait")
    }
    
    func hideProgressHUD() {
        SVProgressHUD.dismiss()
    }
    
    func getHeaderWithAPIName(serviceName: String) -> HTTPHeaders {
        let headers: HTTPHeaders = ["Content-Type": "application/json", "Accept" : "application/json"]
        return headers
    }
    
    func getServiceUrl(string: String) -> String {
        if string.contains("http") {
            return string
        } else {
            return kBASEURL + string
        }
    }
    
    func getPrintableParamsFromJson(postData: Dictionary<String, Any>) -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: postData, options: JSONSerialization.WritingOptions.prettyPrinted)
            let theJSONText = String(data:jsonData, encoding:String.Encoding.ascii)
            return theJSONText ?? ""
        } catch {
            debugPrint(error)
            return ""
        }
    }
    
    func getResponseDataArrayFromData(data: Data) -> (responseData: [Any]?, error: Error?) {
        do {
            let responseData = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [Any]
            print("Success with JSON: \(String(describing: responseData))")
            return (responseData, nil)
        } catch {
            debugPrint("json error: \(error.localizedDescription)")
            return (nil, error)
        }
    }
    
    func getResponseDataDictionaryFromData(data: Data) -> (responseData: Dictionary<String, Any>?, error: Error?) {
        do {
            let responseData = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? Dictionary<String, Any>
            print("Success with JSON: \(String(describing: responseData))")
            return (responseData, nil)
        } catch {
            debugPrint("json error: \(error.localizedDescription)")
            return (nil, error)
        }
    }
    
    func printResponseDataForResponse(response: AFDataResponse<Any>) {
        debugPrint(response.request as Any)
        debugPrint(response.response as Any)
        debugPrint(response.data as Any)
        debugPrint(response.result)
    }
    
    func encryptRequestString(requestStr: String)-> String {
        return ""
    }
    
    func getCurrentTimeStamp()-> TimeInterval {
        return NSDate().timeIntervalSince1970.rounded();
    }
    
    func logoutUser() {
    }
    
    func parseError(fromObject response: Any?) {
    }
    
    func parseErrorCallBack(fromObject response: Any?, completionClosure:@escaping (_ response: Any?) -> ()) -> Void {
        guard let _ = response as? Dictionary<String, Any> else { return }
        completionClosure(response)
    }

    func getArray(array: Any?) -> [Any] {
        guard let array = array as? [Any] else { return [] }
        return array
    }
    
    func getDictionary(dictData: Any?) -> Dictionary<String, Any> {
        guard let dict = dictData as? Dictionary<String, Any> else {
            guard let array = dictData as? [Any] else { return ["":""] }
            return getDictionary(dictData: array.count > 0 ? array[0] : ["":""])
        }
        return dict
    }
    
    func convertJSONToString(fromDict dict: Dictionary<String, Any>) -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            return String.init(data: jsonData, encoding: .utf8) ?? ""
        } catch {
            print(error)
        }
        return ""
    }
    
    func convertStringToJSON(fromString strJSON: String) -> Dictionary<String, Any> {
        guard let data = strJSON.data(using: .utf8) else { return ["":""] }
        
        do {
            let dict = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            return getDictionary(dictData: dict)
        } catch {
            print(error)
        }
        return ["":""]
    }
    
    func convertImageToBase64String (img: UIImage) -> String {
        let imageData: NSData = img.jpegData(compressionQuality: 0.50)! as NSData
        let imgString = imageData.base64EncodedString(options: .init(rawValue: 0))
        return imgString
    }
}

