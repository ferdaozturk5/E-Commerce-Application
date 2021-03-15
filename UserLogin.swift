//
//  UserLogin.swift
//  FinalProject
//
//  Created by Ferda Öztürk on 1.02.2021.
//
import Foundation

// MARK: - UserLogin
struct UserLogin: Codable {
    let user: [User]
}

// MARK: - User
struct User: Codable {
    let durum: Bool
    let mesaj: String
    let bilgiler: Bilgiler?
}

// MARK: - Bilgiler
struct Bilgiler: Codable {
    let userID, userName, userSurname, userEmail: String
    let userPhone, face, faceID: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case userName, userSurname, userEmail, userPhone, face, faceID
    }
}
