//
//  NetworkHelpers.swift
//  ITEA_14
//
//  Created by Oleksandr Kurtsev on 12/06/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import Foundation
import Alamofire

class NetworkHelpers {

    // MARK: - Properties
    
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
    
    func getHeaderWithAPIName(stringURL: String) -> HTTPHeaders {
        // Any logic for adding headers
        let headers: HTTPHeaders = ["key": "value", "key": "value"]
        return headers
    }
    
    func getUrlFromString(stringURL: String) -> String {
        if stringURL.contains("http") {
            return stringURL
        } else {
            return baseURL + stringURL
        }
    }
    
    func getParamsFromJSON(parameters: Parameters) -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options:JSONSerialization.WritingOptions.prettyPrinted)
            let jsonText = String(data:jsonData, encoding:String.Encoding.ascii)
            return jsonText ?? ""
        } catch {
            debugPrint(error.localizedDescription)
            return ""
        }
    }
    
    func getResponseDataDictionaryFromData(data: Data) -> (dictData: Dictionary<String, Any>?, error: Error?) {
        do {
            let dictData = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? Dictionary<String, Any>
            return (dictData, nil)
        } catch {
            debugPrint(error.localizedDescription)
            return (nil, error)
        }
    }
    
    func getResponseDataArrayFromData(data: Data) -> (arrayData: [Any]?, error: Error?) {
        do {
            let arrayData = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [Any]
            return (arrayData, nil)
        } catch {
            debugPrint(error.localizedDescription)
            return (nil, error)
        }
    }
    
    func getArray(arrayData: Any?) -> [Any] {
        guard let array = arrayData as? [Any] else { return [] }
        return array
    }
    
    func getDictionary(dictData: Any?) -> Dictionary<String, Any> {
        guard let dict = dictData as? Dictionary<String, Any> else {
            guard let array = dictData as? [Any] else { return ["":""] }
            return getDictionary(dictData: array.count > 0 ? array[0] : ["":""])
        }
        return dict
    }
    
    func convertImageToBase64String(image: UIImage) -> String {
        let imageData: NSData = image.jpegData(compressionQuality: 0.50)! as NSData
        let imageString = imageData.base64EncodedString(options: .init(rawValue: 0))
        return imageString
    }
}
