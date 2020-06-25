//
//  FirestoreManager.swift
//  PostPigeon
//
//  Created by Oleksandr Kurtsev on 22/06/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class FirestoreManager {
    
    // MARK: - Properties
    static let shared = FirestoreManager()
    private let dataBase = Firestore.firestore()
    private init() {}
    
    private var usersReference: CollectionReference {
        return dataBase.collection("users")
    }
    
    var currentUser: MUser!
    
    // MARK: - Methods
    func saveProfile(muser: MUser, userImage: UIImage?, completion: @escaping (Result<MUser, Error>) -> Void) {
        self.usersReference.document(muser.id).setData(muser.representation) { (error) in
            guard let error = error else {
                completion(.success(muser))
                return
            }
            completion(.failure(error))
        }
    }
    
    func getUserData(user: User, completion: @escaping (Result<MUser, Error>) -> Void) {
        let docRef = usersReference.document(user.uid)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                guard let muser = MUser(document: document) else {
                    completion(.failure(FirestoreError.cannotUnwrapToMUser))
                    return
                }
                self.currentUser = muser
                completion(.success(muser))
            } else {
                completion(.failure(FirestoreError.cannotGetUserInfo))
            }
        }
    }
    
//    func createWaitingChat(message: String, receiver: MUser, completion: @escaping (Result<Void, Error>) -> Void) {
//        let reference = dataBase.collection(["users", receiver.id, "waitingChat"].joined(separator: "/"))
//        let messageRef = reference.document(self.currentUser.id).collection("messages")
//        let username = currentUser.lastName + " " + currentUser.firstName
//        let chat = MChat(friendUsername: username, friendAvatarStringURL: currentUser.avatarStringURL, lastMessageContent: "lastMessageContent", friendId: currentUser.id)
//        reference.document(currentUser.id).setData(<#T##documentData: [String : Any]##[String : Any]#>, completion: <#T##((Error?) -> Void)?##((Error?) -> Void)?##(Error?) -> Void#>)
//    }
}
