//
//  ViewController.swift
//  ITEA_11
//
//  Created by Oleksandr Kurtsev on 02/06/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    var networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "urlsessionSegue" {
            guard let svc = segue.destination as? SecondViewController else { return }
            
            networkManager.fetchCurrentUser()
            networkManager.onCompletion = { [weak self] currentUser in
                guard self != nil else { return }
                svc.updateInterface(with: currentUser)
            }
        }
        
        if segue.identifier == "alamofireSegue" {
            guard let svc = segue.destination as? SecondViewController else { return }
            
            AF.request("https://fakemyapi.com/api/fake?id=\(id)").response { response in
                guard let data = response.data else { return }
                if let currentUser = self.networkManager.parseJSON(with: data) {
                    svc.updateInterface(with: currentUser)
                }
            }
            
        }
    }
    
}

