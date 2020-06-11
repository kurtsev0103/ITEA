//
//  ViewController.swift
//  TEST
//
//  Created by Oleksandr Kurtsev on 11/06/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let apiStr = "https://api-football-v1.p.rapidapi.com/v2/teams/league/2"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.sharedInstance.requestApi(serviceName: apiStr, method: .GET, postData: [:], withProgressHUD: false) { (any, error, errorType, response) in
            if let response = response {
                print(response)
            }
        }
    }


}

