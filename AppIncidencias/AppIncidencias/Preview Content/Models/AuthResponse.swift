//
//  AuthResponse.swift
//  AppIncidencias
//
//  Created by user281478 on 5/30/25.
//

import Foundation

struct AuthResponse: Codable {
    let accessToken: String
    let user: Usuario

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case user
    }
}
