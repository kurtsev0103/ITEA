//
//  NetworkHelpers.swift
//  tEXT filter
//
//  Created by macbook pro on 12/1/19.
//  Copyright © 2019 cyb. All rights reserved.
//

import Foundation
import SVProgressHUD
import Alamofire

class NetworkHelpers: NSObject {
    
    private static var _manager: NetworkHelpers?
    
    static var shared: NetworkHelpers {
        get {
            // Checks if realm has been initialized, if it hasn't initialize it.
            if _manager == nil {
                _manager = NetworkHelpers()
                
            }
            return _manager!
        }
        
        set {
            _manager = newValue
        }
    }
    
    //MARK:- Private Method
    func showProgressHUD()
    {
        SVProgressHUD.show(withStatus: "Please Wait")
    }
    
    func hideProgressHUD() {
        SVProgressHUD.dismiss()
    }
    
    func getHeaderWithAPIName(serviceName: String) -> [String: String]
    {
        // Add AES authentication ...........
        //let headers:[String:String] = ["AppVersion": kAppVersion, "Content-Type":"application/json", "Accept":"application/json", kAuthentication : encryptRequestString(requestStr: serviceName)]
        var headers:[String: String] = ["Content-Type": "application/json", "Accept" : "application/json"]
//        if kSharedUserDefaults.isUserLoggedIn()
//        {
//            headers["Authorization"] = "token " + String.getString(message: kSharedUserDefaults.object(forKey: kApiToken))
//            print_debug(items: "Auth Token --------------------- \(String.getString(message: kSharedUserDefaults.object(forKey: kApiToken)))")
//        }
        
        let timeZoneName = TimeZone.current.identifier
        //headers["device-timezone"] = String.getString(message: timeZoneName)
        
        return headers
    }
    
    func getServiceUrl(string: String) -> String
    {
        if string.contains("http")
        {
            return string
        }
        else
        {
            return kBASEURL + string
        }
    }
    
    func getPrintableParamsFromJson(postData: Dictionary<String, Any>) -> String
    {
        do
        {
            let jsonData = try JSONSerialization.data(withJSONObject: postData, options:JSONSerialization.WritingOptions.prettyPrinted)
            let theJSONText = String(data:jsonData, encoding:String.Encoding.ascii)
            return theJSONText ?? ""
        }
        catch let error as NSError
        {
            //print_debug(items: error)
            return ""
        }
    }
    
    func getResponseDataArrayFromData(data: Data) -> (responseData: [Any]?, error: NSError?)
    {
        do
        {
            let responseData = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [Any]
            print("Success with JSON: \(responseData)")
            return (responseData, nil)
        }
        catch let error as NSError
        {
            //print_debug(items: "json error: \(error.localizedDescription)")
            return (nil, error)
        }
    }
    
    func getResponseDataDictionaryFromData(data: Data) -> (responseData: Dictionary<String, Any>?, error: Error?)
    {
        do
        {
            let responseData = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? Dictionary<String, Any>
            print("Success with JSON: \(responseData)")
            return (responseData, nil)
        }
        catch let error
        {
            //print_debug(items: "json error: \(error.localizedDescription)")
            return (nil, error)
        }
    }
    
//    func printResponseDataForResponse(response: DataResponse<Any>)
//    {
//        print_debug(items: response.request)  // original URL request
//        print_debug(items: response.response) // URL response
//        print_debug(items: response.data)     // server data
//        print_debug(items: response.result)   // result of response serialization
//    }
    
    func encryptRequestString(requestStr: String)-> String
    {
        //    let plainTextStr = requestStr+"_\(getCurrentTimeStamp())"
        //    let encyptedStrng = TAAESCrypt.encrypt(plainTextStr, password: kEncryptionKey)
        //    print("encyptedStrng: \(encyptedStrng)")
        return ""
    }
    
    func getCurrentTimeStamp()-> TimeInterval
    {
        return NSDate().timeIntervalSince1970.rounded();
    }
    
//    func parseError(fromObject response: Any?)
//    {
//        guard let dictResponse = response as? Dictionary<String, Any> else
//        {
//            //baseView.showOkAlertViewController(msg: PLEASE_TRY_AGAIN)
//            return
//        }
//
//        //let key = String.getString(message: dictResponse.keys.first)
//        guard let response = dictResponse[key] as? String else
//        {
//            guard let arrResponse = dictResponse[key] as? [Any] else
//            {
//               //baseView.showOkAlertViewController(msg: PLEASE_TRY_AGAIN)
//                return
//            }
//            //baseView.showOkAlertViewController(msg: String.getString(message: arrResponse.first))
//            return
//        }
//        //baseView.showOkAlertViewController(msg: response)
//    }
    
    func parseErrorCallBack(fromObject response: Any?, completionClosure:@escaping (_ response: Any?) -> ()) -> Void
    {
        guard let dictResponse = response as? Dictionary<String, Any> else
        {
            //completionClosure(PLEASE_TRY_AGAIN)
            //            showOkAlertViewController(msg: PLEASE_TRY_AGAIN)
            return
        }
        
//        let key = String.getString(message: dictResponse.keys.first)
//        guard let response = dictResponse[key] as? String else
//        {
//            guard let arrResponse = dictResponse[key] as? [Any] else
//            {
//                completionClosure(PLEASE_TRY_AGAIN)
//                //                showOkAlertViewController(msg: PLEASE_TRY_AGAIN)
//                return
//            }
//            completionClosure(String.getString(message: arrResponse.first))
//            
//            //            showOkAlertViewController(msg: String.getString(message: arrResponse.first))
//            return
//        }
        completionClosure(response)
        //        showOkAlertViewController(msg: response)
    }

    func getArray(array: Any?) -> [Any]
    {
        guard let arr = array as? [Any] else
        {
            return []
        }
        return arr
    }
    
    func getDictionary(dictData: Any?) -> Dictionary<String, Any>
    {
        guard let dict = dictData as? Dictionary<String, Any> else
        {
            guard let arr = dictData as? [Any] else
            {
                return ["":""]
            }
            return getDictionary(dictData: arr.count > 0 ? arr[0] : ["":""])
        }
        return dict
    }
    
    func convertJSONToString(fromDict dict: Dictionary<String, Any>) -> String
    {
        do
        {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            return String.init(data: jsonData, encoding: .utf8) ?? ""
        }
        catch let error
        {
            print(error)
        }
        return ""
    }
    
    func convertStringToJSON(fromString strJSON: String) -> Dictionary<String, Any>
    {
        guard let data = strJSON.data(using: .utf8) else { return ["":""] }
        
        do
        {
            let dict = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            return getDictionary(dictData: dict)
        }
        catch let error
        {
            print(error)
        }
        return ["":""]
    }
    
    func convertImageToBase64String (img: UIImage) -> String {
        let imageData:NSData = img.jpegData(compressionQuality: 0.50)! as NSData //UIImagePNGRepresentation(img)
        let imgString = imageData.base64EncodedString(options: .init(rawValue: 0))
        return imgString
    }
}

