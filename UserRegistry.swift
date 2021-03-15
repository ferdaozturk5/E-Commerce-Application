//
//  UserRegistry.swift
//  FinalProject
//
//  Created by Ferda Öztürk on 3.02.2021.
//
import Foundation

// MARK: - UserRegistry
struct UserRegistry: Codable {
    let user: [UserReg]
}

// MARK: - UserReg
struct UserReg: Codable {
    let durum: Bool
    let mesaj,kullaniciID: String?
    enum CodingKeys: String, CodingKey {
        case durum, mesaj
        case kullaniciID = "kullaniciId"
    }
    }

