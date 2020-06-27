//
//  StorageManager.swift
//  iTraveler
//
//  Created by Oleksandr Kurtsev on 16/06/2020.
//  Copyright © 2020 Oleksandr Kurtsev. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseStorage

class StorageManager {
    
    // MARK: - Properties
    
    static let shared = StorageManager()
    private init() {}
    
    let storageReference = Storage.storage().reference()
    
    private var avatarsReference: StorageReference {
        return storageReference.child("avatars")
    }
    
    private var imagesReference: StorageReference {
        return storageReference.child("images")
    }
    
    // MARK: - Methods
    
    func upload(userPhoto: UIImage, userId: String, completion: @escaping (Result<URL, Error>) -> Void) {
        guard let scaledImage = userPhoto.scaleToSafeUploadSize else { return }
        guard let imageData = scaledImage.jpegData(compressionQuality: 0.4) else { return }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        avatarsReference.child(userId).putData(imageData, metadata: metadata) { (metadata, error) in
            guard let _ = metadata else {
                completion(.failure(error!))
                return
            }
            self.avatarsReference.child(userId).downloadURL { (url, error) in
                guard let downloadURL = url else {
                    completion(.failure(error!))
                    return
                }
                completion(.success(downloadURL))
            }
        }
    }
    
    func uploadImage(image: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
        guard let scaledImage = image.scaleToSafeUploadSize else { return }
        guard let imageData = scaledImage.jpegData(compressionQuality: 0.4) else { return }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        let imageName = [UUID().uuidString, String(Date().timeIntervalSince1970)].joined()
        let folderName = Auth.auth().currentUser!.uid
        
        self.imagesReference.child(folderName).child(imageName).putData(imageData, metadata: metadata) { (metadata, error) in
            guard let _ = metadata else {
                completion(.failure(error!))
                return
            }
            self.imagesReference.child(folderName).child(imageName).downloadURL { (url, error) in
                guard let downloadURL = url else {
                    completion(.failure(error!))
                    return
                }
                completion(.success(downloadURL))
            }
        }
    }
}
