//
//  FirestoreManager.swift
//  ITEA_14
//
//  Created by Oleksandr Kurtsev on 13/06/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import Foundation
import FirebaseFirestore

class FirestoreManager {
    
    static let shared = FirestoreManager()
    
    let db = Firestore.firestore()
    
    private var usersRef: CollectionReference {
        return db.collection("users")
    }
    
    func savePrifileWith(id: String, name: String?, photoString: String?, bornDate: String?, height: String?, address: String?, phone: String?, completion: @escaping (Result<UserModel, Error>) -> Void) {
        
        guard Validators.isFilled(name: name, bornDate: bornDate, height: height, address: address, phone: phone) else {
            completion(.failure(UserError.notFilled))
            return
        }
        
        let userModel = UserModel(id: id,
                                  name: name!,
                                  address: address!,
                                  photoString: "not exist",
                                  bornDate: bornDate!,
                                  height: height!,
                                  phone: phone!)
        
        self.usersRef.document(userModel.id).setData(userModel.representation) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(userModel))
            }
        }
        
        
    }
    
}
