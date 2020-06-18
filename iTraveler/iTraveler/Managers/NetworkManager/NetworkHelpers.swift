//
//  NetworkHelpers.swift
//  iTraveler
//
//  Created by Oleksandr Kurtsev on 18/06/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import Foundation
import Alamofire

enum HTTPMethod: String {
    case GET, POST, PUT, PATCH, DELETE
}

class NetworkHelpers {
    
    // MARK: - Properties
    
    static let shared = NetworkHelpers()
    private init() {}
    
    private let apiKey = "7102c46b9amshdcbc49f650a47c1p1f3d42jsnac61983b0e7f"
    private let baseURL = ""
    
    // MARK: - Methods
    
    func getUrlFromString(stringURL: String) -> String {
        guard stringURL.contains("http") else { return baseURL + stringURL }
        return stringURL
    }
    
    func getHeaderWithAPIName() -> HTTPHeaders {
        let headers: HTTPHeaders = ["x-rapidapi-host": "restcountries-v1.p.rapidapi.com",
                                    "x-rapidapi-key" : apiKey,
                                    "useQueryString" : "true"]
        return headers
    }
    
    // MARK: - Helper methods for Parse Countries
    
    func parseCountries(_ data: Data) -> Countries? {
        do {
            let countries = try JSONDecoder().decode(Countries.self, from: data)
            return countries
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
